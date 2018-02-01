namespace random_card
{
    partial class GeneralForm
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要修改
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.btStart = new System.Windows.Forms.Button();
            this.tbTableName = new System.Windows.Forms.TextBox();
            this.btStop = new System.Windows.Forms.Button();
            this.numRecordTotal = new System.Windows.Forms.NumericUpDown();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.lbMessage = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.numRecordTotal)).BeginInit();
            this.SuspendLayout();
            // 
            // btStart
            // 
            this.btStart.Location = new System.Drawing.Point(545, 77);
            this.btStart.Name = "btStart";
            this.btStart.Size = new System.Drawing.Size(85, 32);
            this.btStart.TabIndex = 0;
            this.btStart.Text = "开始生成";
            this.btStart.UseVisualStyleBackColor = true;
            this.btStart.Click += new System.EventHandler(this.button1_Click);
            // 
            // tbTableName
            // 
            this.tbTableName.Location = new System.Drawing.Point(103, 18);
            this.tbTableName.Name = "tbTableName";
            this.tbTableName.Size = new System.Drawing.Size(527, 21);
            this.tbTableName.TabIndex = 1;
            // 
            // btStop
            // 
            this.btStop.Location = new System.Drawing.Point(420, 77);
            this.btStop.Name = "btStop";
            this.btStop.Size = new System.Drawing.Size(91, 32);
            this.btStop.TabIndex = 2;
            this.btStop.Text = "关闭";
            this.btStop.UseVisualStyleBackColor = true;
            this.btStop.Click += new System.EventHandler(this.btStop_Click);
            // 
            // numRecordTotal
            // 
            this.numRecordTotal.Location = new System.Drawing.Point(103, 53);
            this.numRecordTotal.Maximum = new decimal(new int[] {
            999,
            0,
            0,
            0});
            this.numRecordTotal.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numRecordTotal.Name = "numRecordTotal";
            this.numRecordTotal.Size = new System.Drawing.Size(120, 21);
            this.numRecordTotal.TabIndex = 3;
            this.numRecordTotal.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(38, 21);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(41, 12);
            this.label1.TabIndex = 4;
            this.label1.Text = "表名：";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(38, 55);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(41, 12);
            this.label2.TabIndex = 5;
            this.label2.Text = "条数：";
            // 
            // lbMessage
            // 
            this.lbMessage.AutoSize = true;
            this.lbMessage.Location = new System.Drawing.Point(38, 87);
            this.lbMessage.Name = "lbMessage";
            this.lbMessage.Size = new System.Drawing.Size(29, 12);
            this.lbMessage.TabIndex = 6;
            this.lbMessage.Text = "准备";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(234, 58);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(23, 12);
            this.label3.TabIndex = 7;
            this.label3.Text = "K条";
            // 
            // GeneralForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(666, 132);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.lbMessage);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.numRecordTotal);
            this.Controls.Add(this.btStop);
            this.Controls.Add(this.tbTableName);
            this.Controls.Add(this.btStart);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.Name = "GeneralForm";
            this.SizeGripStyle = System.Windows.Forms.SizeGripStyle.Show;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "卡号生成";
            ((System.ComponentModel.ISupportInitialize)(this.numRecordTotal)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btStart;
        private System.Windows.Forms.TextBox tbTableName;
        private System.Windows.Forms.Button btStop;
        private System.Windows.Forms.NumericUpDown numRecordTotal;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label lbMessage;
        private System.Windows.Forms.Label label3;
    }
}

