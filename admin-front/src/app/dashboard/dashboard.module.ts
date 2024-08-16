import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CreateEmpleadoComponent } from './create-empleado/create-empleado.component';
import { DashboardComponent } from './dashboard.component';
import { RouterModule, Routes } from '@angular/router';
import { ListEmpleadoComponent } from './list-empleado/list-empleado.component';
import { MaterialModule } from '../material/material.module';
import { ReactiveFormsModule } from '@angular/forms';

const routes:Routes = [
  {
    path:'',
    component:DashboardComponent,
    children:[
      {
        path:'',
        component:ListEmpleadoComponent
      }
    ]
  }
]

@NgModule({
  declarations: [
    CreateEmpleadoComponent,
    DashboardComponent,
    ListEmpleadoComponent    
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(routes),
    MaterialModule,
    ReactiveFormsModule
  ]
})
export class DashboardModule { }
