unit WordUtils;
//When the service is executed under local system user
//the function SaveAs always raises exception "call was rejected by callee"
//To avoid this error, it's necessary to run the service under real user.

interface
uses Windows, Classes, SysUtils, Variants, ComObj, ActiveX;

procedure OpenWord(const srcFileName: String);

implementation

procedure OpenWord(const srcFileName: String);
var app: Variant;
begin
  app := CreateOleObject('Word.Application');
  try
    try
      app.Visible := true;
      app.Documents.Open(srcFileName);
      app.Caption := srcFileName;
      try
        app.ActiveDocument.Paragraphs.Add;  //modify document
        while true do Sleep(100); //hangs
      finally
        app.ActiveDocument.Close;
      end;
    finally
      app.Quit;
    end;
  finally
    app := 0;
  end;
end;

end.
