unit HelpUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw;

type
  THelp = class(TForm)
    Web: TWebBrowser;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Help: THelp;

implementation

{$R *.dfm}

procedure THelp.FormCreate(Sender: TObject);
var
 path:string;
begin
 path:=ExtractFileDir(Application.ExeName)+'/1.htm';
 Web.Navigate(path);
end;

end.
