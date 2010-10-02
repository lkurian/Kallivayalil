using System.Data;
using System.Data.Odbc;
using System.Configuration;

/// <summary>
/// Summary description for AccessDB
/// </summary>
public class AccessDB
{    
    OdbcCommand _command;
    OdbcConnection connection;
    OdbcDataAdapter adapter;
    DataSet dataset;
    string query;

    public string Query
    {
        set { this.query = value; }
        get { return this.query; }
    }

    public DataSet Dataset
    {
        get { return this.dataset; }
    }

    public OdbcCommand command
    {
        get { return _command; }
        set { _command = value; }
    }
    public AccessDB()
    {
        connection = new OdbcConnection(ConfigurationManager.ConnectionStrings["KallivayalilDB"].ConnectionString);      
        command = new OdbcCommand();
        command.Connection = connection;
        adapter = new OdbcDataAdapter(command);
        dataset = new DataSet();
    }

    public void Open()
    {
        connection.Open();
    }

    public void Close()
    {
        connection.Close();
    }

    public int ExecuteNonQuery()
    {
        command.CommandText = query;
        int result = 0;
        result = command.ExecuteNonQuery();
        command.CommandText = "Commit";
        command.ExecuteNonQuery();
        return result;
    }

    public void ExecuteQuery()
    {
        command.CommandText = query;
        adapter.SelectCommand = command;
        adapter.Fill(dataset);
    }

    public object ExecuteScalar()
    {
        command.CommandText = query;
        return command.ExecuteScalar();
    }
    ////public void ExecuteStoredProcedure(string SPName)
    //{        
    //    command.CommandText = SPName;
    //    command.CommandType = CommandType.StoredProcedure;
    //    adapter.SelectCommand = command;
    //    adapter.Fill(dataset);
    //}
}
