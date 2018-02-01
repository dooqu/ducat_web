using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Data;
using System.Threading;
using System.Data.OleDb;

namespace random_card
{
    public partial class GeneralForm : Form
    {
        public class CardGenerateArgs : EventArgs
        {
            public int TotalRecord
            {
                get;set;
            }

            public int GeneratedRecord
            {
                get;set;
            }
        }

        public class ThreadStartArg
        {
            public int TotalRecord
            {
                get;set;
            }

            public string TableName
            {
                get;set;
            }
        }

        public delegate void CardsGenerateProgress(CardGenerateArgs e);
        public event CardsGenerateProgress OnCardsGenerateProgress;
        public Random rand;
        public GeneralForm()
        {
            InitializeComponent();
            rand = new Random();            
            OnCardsGenerateProgress += GeneralForm_OnCardsGenerateProgress;
        }

        private void GeneralForm_OnCardsGenerateProgress(CardGenerateArgs e)
        {
            if(this.InvokeRequired)
            {
                CardsGenerateProgress p = new CardsGenerateProgress(this.GeneralForm_OnCardsGenerateProgress);
                this.Invoke(p, e);
                return;
            }

            lbMessage.Text = "当前进度:" + e.GeneratedRecord + "/" + e.TotalRecord;

            if(e.TotalRecord == e.GeneratedRecord)
            {
                btStart.Enabled = true;
                btStop.Enabled = true;
                lbMessage.Text = string.Format("{0}条记录已经成功生成", e.TotalRecord);
            }
        }

        void CreateAccessTable(string tableName)
        {
            OleDbConnection conn = new OleDbConnection();
            conn.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + System.IO.Path.Combine(Environment.CurrentDirectory, "generate_card.mdb");
            conn.Open();

            OleDbCommand query = new OleDbCommand();
            query.Connection = conn;
            query.CommandText = string.Format("create table card_{0} (ID AUTOINCREMENT(1,1), CardNum char(16) primary key not null, CardPass char(8) not null, CONSTRAINT uc_PersonID UNIQUE(CardPass));", tableName);
            
            query.ExecuteNonQuery();
            conn.Close();
        }

        void CreateCardsAtTable(string tableName, int recordTotal)
        {
            CreateAccessTable(tableName);
            ThreadStartArg arg = new ThreadStartArg();
            arg.TotalRecord = recordTotal * 1000;
            arg.TableName = tableName;

            Thread t = new Thread(new ParameterizedThreadStart(CreateCardsAtTableProgress));
            t.IsBackground = true;
            t.Start(arg);
        }

        void CreateCardsAtTableProgress(object arg)
        {
            int recordTotal = (arg as ThreadStartArg).TotalRecord;
            string tableName = (arg as ThreadStartArg).TableName;

            OleDbConnection conn = new OleDbConnection();
            conn.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + System.IO.Path.Combine(Environment.CurrentDirectory, "generate_card.mdb");
            conn.Open();

            OleDbCommand query = new OleDbCommand();
            query.Connection = conn;
            query.CommandText = string.Format("INSERT INTO card_{0} (CardNum, CardPass) VALUES (@CardNum, @CardsPass);", tableName);
            query.Parameters.Add("@CardNum", OleDbType.Char, 16);
            query.Parameters.Add("@CardPass", OleDbType.Char, 8);   
            
            for(int i = 0; i < recordTotal; )
            {
                query.Parameters["@CardNum"].Value = GetRandomCardNum();
                query.Parameters["@CardPass"].Value = GetRandomCardPass();
                int r = query.ExecuteNonQuery();

                if(r > 0)
                {
                    i++;

                    CardGenerateArgs e = new CardGenerateArgs();
                    e.TotalRecord = recordTotal;
                    e.GeneratedRecord = i;

                    if(OnCardsGenerateProgress != null)
                    {
                        OnCardsGenerateProgress(e);
                    }
                }
            }         
            
            conn.Close();
        }

        string GetRandomCardNum()
        {
            char[] cardNumArr = new char[16];
            cardNumArr[0] = 'E';
            cardNumArr[1] = 'N';

            for(int i = 2; i < 16; i++)
            {
                cardNumArr[i] = (char)rand.Next(48, 58);
            }

            return new string(cardNumArr);
        }

        string GetRandomCardPass()
        {
            char[] cardPassArr = new char[8];
            for(int i = 0; i < 8; i++)
            {
                cardPassArr[i] = (char)rand.Next(65, 91);
            }
            return new string(cardPassArr);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (tbTableName.Text.Trim() == "")
            {
                MessageBox.Show("请输入表名");
                return;
            }

            if (tbTableName.Text.Trim().IndexOf(' ') != -1)
            {
                MessageBox.Show("表名不能含有空格");
                return;
            }

            try
            {
                btStart.Enabled = false;
                btStop.Enabled = false;
                CreateCardsAtTable(tbTableName.Text.Trim(), (int)numRecordTotal.Value);
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
                btStart.Enabled = true;
                btStop.Enabled = true;
            }
            
        }

        private void btStop_Click(object sender, EventArgs e)
        {
 
            this.Close();
        }
    }
}
