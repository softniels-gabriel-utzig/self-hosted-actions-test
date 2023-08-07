unit Main.Controller;

interface

uses
  MVCFramework,
  MVCFramework.Commons,
  MVCFramework.Serializer.Commons;

type
  [MVCPath]
  TMainController = class(TMVCController)
  public
    [MVCPath('')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/ping')]
    [MVCHTTPMethod([httpGET])]
    procedure Ping;
  end;

implementation

uses
  System.SysUtils,
  MVCFramework.Logger,
  System.StrUtils;

procedure TMainController.Index;
begin
  Render(HTTP_STATUS.OK, '{"message": "Auuuuuuuu"}');
end;

procedure TMainController.Ping;
begin
  Render(HTTP_STATUS.OK, '{"message": "au au"}');
end;

end.

