//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WAHM.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class PERSONAS
    {
        public long ID_PERSONA { get; set; }
        public string PRIMER_NOMBRE { get; set; }
        public string SEGUNDO_NOMBRE { get; set; }
        public string PRIMER_APELLIDO { get; set; }
        public string SEGUNDO_APELLIDO { get; set; }
        public string TIPO_IDENTIFICACION { get; set; }
        public long IDENTIFICACION { get; set; }
        public long NO_CELULAR { get; set; }
        public string DIRECCION { get; set; }
        public string CORREO_ELECTRONICO { get; set; }
    }
}
