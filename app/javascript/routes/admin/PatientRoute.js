import Index from "@/pages/admin/patients/Index";
// import AddRoutine from "@/pages/admin/patients/AddRoutine";
import Show from "@/pages/admin/patients/Show";

const patientRoutes = [
  {
    path: "/admin/pacientes",
    name: "admin-patients",
    component: Index,
    meta: { resource: "Patient" }
  },
  // {
  //   path: "/admin/pacientes/agregar-rutina",
  //   name: "admin-patients-add-routine",
  //   component: AddRoutine,
  //   meta: { resource: "Patient", action: "addRoutine" },
  // },
  {
    path: "/admin/pacientes/:id",
    name: "admin-patients-show",
    component: Show,
    meta: { resource: "Patient", action: "show" }
  }
];

export default patientRoutes;
