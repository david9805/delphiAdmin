import { Component, Inject } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { ActivatedRoute } from '@angular/router';
import { EmpleadoService } from 'src/app/services/empleado.service';

@Component({
  selector: 'app-create-empleado',
  templateUrl: './create-empleado.component.html',
  styleUrls: ['./create-empleado.component.css']
})
export class CreateEmpleadoComponent {

  identificacion:FormControl = new FormControl(0,[Validators.required]);
  nombres:FormControl = new FormControl(null,[Validators.required]);
  apellidos:FormControl = new FormControl(null,[Validators.required]);
  cargo:FormControl = new FormControl(null,[Validators.required]);
  idDependencia:FormControl = new FormControl(0,[Validators.required]);

  element:any;

  id:number = 0 ;

  dataEmpleado:any;

  empleadoForm = new FormGroup({
    identificacion:this.identificacion,
    nombres:this.nombres,
    apellidos:this.apellidos,
    cargo:this.cargo,
    idDependencia:this.idDependencia
  });

  constructor(private empleadoService:EmpleadoService,
              @Inject(MAT_DIALOG_DATA) data:any,
              private dialogRef:MatDialogRef<CreateEmpleadoComponent>
  ){
    if (data){
      const element = data.element;
      this.id = element.id;
      this.dataEmpleado = element;      
    }
  }

  ngOnInit(): void {
    this.upData();            
    this.loadData();
  }

  get titleModal(){
    return this.id ? 'Editar Empleado' : 'Crear Empleado'
  }

  upData(){
    if(this.dataEmpleado){
      console.log(this.dataEmpleado);
      this.identificacion.setValue(this.dataEmpleado.identificacion);
      this.nombres.setValue(this.dataEmpleado.nombres);
      this.apellidos.setValue(this.dataEmpleado.apellidos);
      this.cargo.setValue(this.dataEmpleado.cargo);
      this.idDependencia.setValue(this.dataEmpleado.fkDependencia);
    }
  }
  
  loadData(){
    this.empleadoService.getDependencias().subscribe(
      (data:any)=>{
        const result:any[] =data.result;        
        result.forEach(element => {
          this.element = element;
          if (!this.dataEmpleado){
            this.idDependencia.setValue(this.element[1].id);
          }          
        });
        
      },
      error=>{

      }
    )
  }

  save(){
    if (this.empleadoForm.invalid){
      this.empleadoForm.markAllAsTouched();
      return;
    }
    if (this.dataEmpleado){
       
      this.empleadoService.putEmpleados(this.id,this.empleadoForm.value).subscribe(
        data=>{
          this.dialogRef.close();
        },
        error=>{
          console.error(error.error)
        }
      )
    }
    else{
      this.empleadoService.postEmpleados(this.empleadoForm.value).subscribe(
        data=>{
          console.log(data);
          this.dialogRef.close();
        },
        error=>{
          console.error(error.error);
        }
      )
    }    
  }

  close(){
    this.dialogRef.close();
  }
}
