program Start;

uses
  Forms,
  GameUnit in 'GameUnit.pas' {GameForm},
  HelpUnit in 'HelpUnit.pas' {Help};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGameForm, GameForm);
  Application.CreateForm(THelp, Help);
  Application.Run;
end.
