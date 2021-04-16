export default {
  esAR: {
    views: {
      app: {
        title: "Avisos BO"
      },
      commons: {
        sortBy: "Ordenar por",
        actions: "Acciones",
        filters: "Filtros",
        date: {
          from: "Desde",
          to: "Hasta"
        },
        undiscarded: "Activo",
        discarded: "Eliminado",
        confirmation:
          "¿Esta seguro que desea %{action}? Esta acción no se puede deshacer",
        emptyList: "No hay elementos disponibles para mostrar",
        unresolvedObservations: "Tiene observaciones pendientes",
        updatedSometimeAgoBySomeone: "actualizado %{sometime} por %{someone}"
      },
      actions: {
        show: "Ver",
        edit: "Editar",
        new: "Nuevo",
        destroy: "Borrar definitivamente",
        reallyDestroy: "Borrar definitivamente",
        undiscard: "Restaurar",
        discard: "Borrar",
        save: "Guardar",
        download: "Descargar",
        cancel: "Cancelar",
        back: "Volver",
        filter: "Filtrar",
        filters: "Filtros",
        reset: "Limpiar",
        signOut: "Cerrar sesión",
        menu: "Menu",
        resolve: "Resolver",
        unresolve: "Volver a estado pendiente",
        archive: "Archivar",
        unarchive: "Desarchivar",
        startSupervision: "Agregar a mis pacientes",
        stopSupervision: "Dejar de supervisar",
        addRoutine: "Agregar runtina",
        messages: {
          confirm: "¿Desea continuar?",
          alertAction: "La acción no podrá deshacerse.",
          success: "La operación se realizó con éxito",
          successDownload: "La descarga se realizó con éxito",
          downloadError: "Hubo un error en la descarga"
        },
        reject: "Rechazar"
      },
      menu: {
        administration: "Administración",
        home: "Inicio",
        dashboard: "Inicio",
        exercises: "Ejercicios",
        patients: "Pacientes",
        users: "Usuarios",
        groups: "Grupos",
        changePassword: "Cambiar contraseña"
      },
      base: {
        headers: {
          id: "ID",
          state: "Estado",
          actions: "Acciones",
          enabled: "¿Activo?"
        }
      },
      exercises: {
        index: {
          title: "Ejercicios",
          search: "Buscar ejercicios"
        },
        new: {
          title: "Nuevo ejercicio"
        },
        form: {
          removeExerciseStep: "Remover paso",
          addExerciseStep: "Agregar paso"
        },
        destroy: {
          notice: "El ejercicio %{exercise} fue eliminado definitivamente."
        }
      },
      patients: {
        index: {
          title: "Pacientes",
          search: "Buscar pacientes"
        },
        addRoutineForm: {
          addRoutineExercise: "Agregar ejercicio",
          removeRoutineExercise: "Borrar ejercicio"
        },
        stopSupervision: {
          notice: "Se ha dejado de supervisar el paciente %{patient}."
        },
        startSupervision: {
          notice: "Se ha comenzado supervisar el paciente %{patient}."
        }
      },
      routines: {
        discard: {
          notice: "La rutina %{routine} ha sido archivada existosamente."
        },
        undiscard: {
          notice: "La rutina %{routine} ha sido desarchivada existosamente."
        },
        destroy: {
          notice: "La rutina %{routine} fue eliminada definitivamente."
        },
        create: {
          notice: "La rutina %{routine} ha sido creada existosamente."
        }
      },
      users: {
        index: {
          title: "Usuarios",
          search: "Buscar usuarios"
        },
        headers: {
          username: "Nombre",
          confirmed: "¿Confirmado?",
          lastAccess: "Último acceso",
          lastIP: "Última IP"
        },
        new: {
          title: "Nuevo usuario"
        },
        edit: {
          title: "Editar usuario %{user}"
        },
        create: {
          notice: "El usuario %{user} fue creado exitosamente."
        },
        update: {
          notice: "El usuario %{user} fue actualizado exitosamente."
        },
        destroy: {
          notice: "El usuario %{user} fue eliminado definitivamente."
        },
        discard: {
          notice: "El usuario %{user} fue eliminado exitosamente."
        },
        undiscard: {
          notice: "El usuario %{user} fue restaurado exitosamente."
        },
        change_password: {
          title: "Cambiar contraseña"
        },
        update_password: {
          notice: "La contraseña se ha actualizado exitosamente."
        }
      },
      groups: {
        index: {
          title: "Grupos",
          search: "Buscar grupos"
        },
        headers: {
          name: "Nombre"
        },
        new: {
          title: "Nuevo grupo"
        },
        edit: {
          title: "Editar grupo %{group}"
        },
        create: {
          notice: "El grupo %{group} fue creado exitosamente."
        },
        update: {
          notice: "El grupo %{group} fue actualizado exitosamente."
        },
        destroy: {
          notice: "El grupo %{group} fue eliminado definitivamente.",
          alert:
            "El grupo %{group} no puede ser eliminado porque tiene usuarios relacionados."
        },
        discard: {
          notice: "El grupo %{group} fue eliminado exitosamente."
        },
        undiscard: {
          notice: "El grupo %{group} fue restaurado exitosamente."
        }
      }
    },
    models: {
      user: {
        one: "Usuario",
        other: "Usuarios"
      },
      group: {
        one: "Grupo",
        other: "Grupos"
      }
    },
    attributes: {
      common: {
        createdAt: "Fecha de creación"
      },
      base: {
        state: "Estado"
      },
      exercise: {
        name: "Nombre",
        exerciseType: "Tipo",
        exerciseSteps: "Pasos",
        description: "Descripción"
      },
      exerciseStep: {
        goal: "Objetivo",
        time: "Tiempo"
      },
      routine: {
        dailyLimit: "Limite diario",
        routineExercises: "Ejercicios"
      },
      routineExercise: {
        repetitions: "Repeticiones",
        exercise: "Ejercicio",
        exerciseId: "Ejercicio"
      },
      routineIntent: {
        statuses: {
          finished: "Terminada",
          unfinished: "Sin terminar"
        },
        status: "Estado"
      },
      user: {
        username: "Nombre de usuario",
        fullname: "Nombre completo",
        email: "Correo electrónico",
        lastSignInAt: "Último inicio de sesión",
        lastSignInIp: "Última dirección IP",
        groups: "Grupos",
        supervisor: "Supervisor"
      },
      group: {
        name: "Nombre de grupo"
      }
    }
  }
};
