import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class EmpleadoService {
  private url = 'http://localhost:8080/datasnap/rest/TEmpleados/';
  constructor(private http:HttpClient) { }

  getDependencias(){
    const url = this.url + 'getDependencias';
    return this.http.get(url);
  }

  getEmpleados(){
    const url = this.url + 'getEmpleados';
    return this.http.get(url);
  }

  getByIdEmpleados(){

  }

  postEmpleados(body:any){
    const url = this.url + 'createEmpleados';
    return this.http.post(url,body);
  }

  putEmpleados(id:number,body:any){
    const url = this.url +'putEmpleado/'+id.toString();
    return this.http.put(url,body);
  }
}
