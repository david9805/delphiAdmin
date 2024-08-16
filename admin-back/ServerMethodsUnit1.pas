unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet,Web.HTTPApp;

type
{$METHODINFO ON}
  TEmpleados = class(TDataModule)
    fdConnection: TFDConnection;
    fdDependencias: TFDQuery;
    fdDependenciasid: TFDAutoIncField;
    fdDependenciasnombreDependencia: TStringField;
    fdEmpleados: TFDQuery;
    fdEmpleadosid: TFDAutoIncField;
    fdEmpleadosidentificacion: TIntegerField;
    fdEmpleadosnombres: TStringField;
    fdEmpleadosapellidos: TStringField;
    fdEmpleadoscargo: TStringField;
    fdEmpleadosfkDependencia: TIntegerField;
    fdEmpleadoscreatedAt: TSQLTimeStampField;
    fdEmpleadosupdatedAt: TSQLTimeStampField;
    fdEmpleadosnombreDependencia: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }

    function getDependencias: TJSONArray;
    function getEmpleados:TJSONArray;
    function getEmpleadosById(id:Integer):TJSONObject;
    function updatecreateEmpleados(body:TJSONObject):TJSONObject;
    function acceptputEmpleado(id:Integer;body:TJSONObject):Boolean;
  end;
{$METHODINFO OFF}

implementation


{$R *.dfm}


uses System.StrUtils;


function TEmpleados.getDependencias: TJSONArray;
var
  JSONArray: TJSONArray;
  JSONObj: TJSONObject;
begin
  fdDependencias.Close;
  fdDependencias.Open;

  JSONArray := TJSONArray.Create;
  try
    fdDependencias.First;
    while not fdDependencias.Eof do
    begin
      JSONObj := TJSONObject.Create;
      JSONObj.AddPair('id', TJSONNumber.Create(fdDependenciasid.AsInteger));
      JSONObj.AddPair('nombreDependencia', fdDependenciasnombreDependencia.AsString);
      JSONArray.AddElement(JSONObj);

      fdDependencias.Next;
    end;
    Result := JSONArray;
  except
    JSONArray.Free;
    raise;
  end;
end;

function TEmpleados.getEmpleados: TJSONArray;
var
JSONArray:TJSONArray;
JSONObj: TJSONObject;
begin
  fdEmpleados.Close;
  fdEmpleados.Open;

  JSONArray:= TJSONArray.Create;
  try
    while not fdEmpleados.Eof do
    begin
      JSONObj:= TJSONObject.Create;
      JSONObj.AddPair('id',TJSONNumber.Create(fdEmpleadosid.AsInteger));
      JSONObj.AddPair('identificacion',TJSONNumber.Create(fdEmpleadosidentificacion.AsInteger));
      JSONObj.AddPair('nombres',fdEmpleadosnombres.Value);
      JSONObj.AddPair('apellidos',fdEmpleadosapellidos.Value);
      JSONObj.AddPair('cargo',fdEmpleadoscargo.Value);
      JSONObj.AddPair('fkDependencia',TJSONNumber.Create(fdEmpleadosfkDependencia.AsInteger));
      JSONObj.AddPair('dependencia',fdEmpleadosnombreDependencia.Value);
      JSONObj.AddPair('createdAt',TJSONString.Create(DateTimeToStr(fdEmpleadoscreatedAt.AsDateTime)));
      JSONObj.AddPair('updatedAt',TJSONString.Create(DateTimeToStr(fdEmpleadosupdatedAt.AsDateTime)));
      JSONArray.AddElement(JSONObj);
      fdEmpleados.Next;
    end;
    Result:=   JSONArray;
  except
    JSONArray.Free;
    raise;
  end;
end;

function TEmpleados.getEmpleadosById(id: Integer): TJSONObject;
begin
  fdEmpleados.Close;
  fdEmpleados.SQL.Text := 'SELECT a.*,b.nombreDependencia FROM empleados as a INNER JOIN dependencias as b ON a.fkDependencia = b.ID WHERE a.id = :id';
  fdEmpleados.ParamByName('id').AsInteger:= id;
  fdEmpleados.Open;
  Result:=TJSONObject.Create;
  if not fdEmpleados.Eof then
  begin
    Result.AddPair('id',TJSONNumber.Create(fdEmpleadosid.AsInteger));
    Result.AddPair('identificacion',TJSONNumber.Create(fdEmpleadosidentificacion.AsInteger));
    Result.AddPair('nombres',fdEmpleadosnombres.Value);
    Result.AddPair('apellidos',fdEmpleadosapellidos.Value);
    Result.AddPair('cargo',fdEmpleadoscargo.Value);
    Result.AddPair('fkDependencia',TJSONNumber.Create(fdEmpleadosfkDependencia.AsInteger));
    Result.AddPair('dependencia',fdEmpleadosnombreDependencia.Value);
    Result.AddPair('createdAt',TJSONString.Create(DateTimeToStr(fdEmpleadoscreatedAt.AsDateTime)));
    Result.AddPair('updatedAt',TJSONString.Create(DateTimeToStr(fdEmpleadosupdatedAt.AsDateTime)));
  end;
end;

function TEmpleados.updatecreateEmpleados(body: TJSONObject): TJSONObject;
var
 JSONObject: TJSONObject;
begin
  if not body.IsEmpty then
  begin
    fdEmpleados.Close;
    fdEmpleados.Open;


    fdEmpleados.Append;
    fdEmpleadosidentificacion.Value:= body.GetValue<Integer>('identificacion');
    fdEmpleadosnombres.Value:= body.GetValue<string>('nombres');
    fdEmpleadosapellidos.Value:= body.GetValue<string>('apellidos');
    fdEmpleadoscargo.Value:= body.GetValue<string>('cargo');
    fdEmpleadosfkDependencia.Value:= body.GetValue<integer>('idDependencia');
    fdEmpleados.Post;

    Result := TJSONObject.Create;
    Result.AddPair('id', TJSONNumber.Create(fdEmpleadosid.AsInteger));
  end;
end;

function TEmpleados.acceptputEmpleado(id:Integer;body: TJSONObject): Boolean;
var
 JSONObject: TJSONObject;
begin

  try
    fdEmpleados.Close;
    fdEmpleados.SQL.Text := 'SELECT a.*,b.nombreDependencia FROM empleados as a INNER JOIN dependencias as b ON a.fkDependencia = b.ID WHERE a.id = :id';
    fdEmpleados.ParamByName('id').AsInteger:= id;
    fdEmpleados.Open;

   if not fdEmpleados.Eof then
    begin


      fdEmpleados.Edit;
      fdEmpleadosnombres.Value:= body.GetValue<string>('nombres');
      fdEmpleadosapellidos.Value:= body.GetValue<string>('apellidos');
      fdEmpleadoscargo.Value:= body.GetValue<string>('cargo');
      fdEmpleadosfkDependencia.Value:= body.GetValue<integer>('idDependencia');
      fdEmpleados.Post;

      Result := True;
    end
    else
    begin
      Result:=False;
    end;
  except
    JSONObject.Free;
    raise;
  end;
end;
end.

