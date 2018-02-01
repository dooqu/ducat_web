using System;
using System.Collections.Generic;
using System.Web;
using System.IO;


namespace api
{
    public class MyTraceListener : System.Diagnostics.TraceListener
    {
        string filePath;
        string filename;

        public MyTraceListener(string filePath)
        {
            this.filePath = filePath;
        }
        public override void Write(string message)
        {
            System.IO.File.AppendAllText(Path.Combine(filePath, string.Format("log-{0}.txt", DateTime.Now.ToString("yyyy-MM-dd"))), message);
        }

        public override void WriteLine(string message)
        {
            System.IO.File.AppendAllText(Path.Combine(filePath, string.Format("log-{0}.txt", DateTime.Now.ToString("yyyy-MM-dd"))), message +  Environment.NewLine);
        }
    }
}