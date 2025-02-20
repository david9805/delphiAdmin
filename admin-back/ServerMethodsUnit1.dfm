object Empleados: TEmpleados
  Height = 480
  Width = 640
  object fdConnection: TFDConnection
    Params.Strings = (
      'Database=empleados'
      'User_Name=root'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    Connected = True
    Left = 304
    Top = 224
  end
  object fdDependencias: TFDQuery
    Connection = fdConnection
    SQL.Strings = (
      'select * from dependencias')
    Left = 424
    Top = 256
    object fdDependenciasid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object fdDependenciasnombreDependencia: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nombreDependencia'
      Origin = 'nombreDependencia'
      Size = 100
    end
  end
  object fdEmpleados: TFDQuery
    Connection = fdConnection
    SQL.Strings = (
      
        'SELECT a.*,b.nombreDependencia FROM empleados as a INNER JOIN de' +
        'pendencias as b ON a.fkDependencia = b.ID')
    Left = 232
    Top = 328
    object fdEmpleadosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object fdEmpleadosidentificacion: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'identificacion'
      Origin = 'identificacion'
    end
    object fdEmpleadosnombres: TStringField
      FieldName = 'nombres'
      Origin = 'nombres'
      Required = True
      Size = 100
    end
    object fdEmpleadosapellidos: TStringField
      FieldName = 'apellidos'
      Origin = 'apellidos'
      Required = True
      Size = 100
    end
    object fdEmpleadoscargo: TStringField
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 50
    end
    object fdEmpleadosfkDependencia: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'fkDependencia'
      Origin = 'fkDependencia'
    end
    object fdEmpleadoscreatedAt: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'createdAt'
      Origin = 'createdAt'
    end
    object fdEmpleadosupdatedAt: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'updatedAt'
      Origin = 'updatedAt'
    end
    object fdEmpleadosnombreDependencia: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'nombreDependencia'
      Origin = 'nombreDependencia'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
  end
end
