import Index from "@/pages/admin/groups/Index";

const groupRoutes = [
  {
    path: "/admin/grupos",
    name: "admin-groups",
    component: Index,
    meta: { resource: "Group" },
  },
];

export default groupRoutes;
