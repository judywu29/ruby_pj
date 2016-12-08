fileHtml = File.new("fred.html", "w+")
fileHtml.puts "<HTML><BODY BGCOLOR='green'>"
fileHtml.puts "<CENTER>this is neat</CENTER><br>"
fileHtml.puts "<CENTER><FONT COLOR='yellow'>this is neat</FONT></CENTER>"
fileHtml.puts "<TABLE BORDER='1' ALIGN='center'>"
fileHtml.puts "<TR><TH>HEADER</TH></TR>"
fileHtml.puts "<TR><TD>Cell in <FONT COLOR='RED'>TableThing</FONT></TD></TR>"
fileHtml.puts "</TABLE>"
fileHtml.puts "<TABLE BORDER='0' ALIGN='center'>"
fileHtml.puts "<TR><TH>HEADER on borderless</TH></TR>"
fileHtml.puts "<TR><TD>Cell in borderless<FONT COLOR='white'>TableThing</FONT></TD></TR>"
fileHtml.puts "</TABLE>"
fileHtml.puts "</BODY></HTML>"
fileHtml.close()