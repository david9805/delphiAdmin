import { Component } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatTableDataSource } from '@angular/material/table';
import { EmpleadoService } from 'src/app/services/empleado.service';
import { CreateEmpleadoComponent } from '../create-empleado/create-empleado.component';

@Component({
  selector: 'app-list-empleado',
  templateUrl: './list-empleado.component.html',
  styleUrls: ['./list-empleado.component.css']
})
export class ListEmpleadoComponent {

  dataSource = new MatTableDataSource([]);

  displayedColumns = ['identificacion','nombres','apellidos','cargo','dependencia','actions'];

  constructor(private empleadoService:EmpleadoService,
              private dialog:MatDialog
  ){

  }

  ngOnInit(): void {
    this.loadData();
  }

  loadData(){
    this.empleadoService.getEmpleados().subscribe(
      (data:any)=>{
        if (data.result){
          this.dataSource = new MatTableDataSource(...data.result);
        }
      },
      error=>{
        console.error(error.error)
      }      
    )
  }
  updateEmpleado(element:any){
    const dialogRef = this.dialog.open(CreateEmpleadoComponent,{
      data:{
        element:element
      }
    });

    dialogRef.afterClosed().subscribe(
      data=>{
        this.loadData();
      }
    );
  }

  createEmpleado(){
    const dialogRef = this.dialog.open(CreateEmpleadoComponent,{
      disableClose: true
    });

    dialogRef.afterClosed().subscribe(
      data=>{
        this.loadData();
      }
    )
  }
}
