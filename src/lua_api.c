#ifdef HAVE_CONFIG_H
#include <config.h>
#endif
#include "lua_api.h"

#include <glib.h>
#include <lualib.h>

#include "log.h"
#include "lua_args.h"
#include "lua_descriptor.h"
#include "lua_log.h"
#include "lua_zmq.h"

static lua_State* lua = NULL;

static gpointer lua_glib_alloc(gpointer ud,
                               gpointer ptr,
                               gsize osize,
                               gsize nsize) {
  (void) ud; /* Not used. */
  (void) osize; /* Not used. */
  if (nsize == 0) {
    g_free(ptr);
    return NULL;
  } else {
    return g_realloc(ptr, nsize);
  }
}

void lua_api_init(gpointer zmq_pub_socket, gint argc, gchar* argv[]) {
  lua = lua_newstate(lua_glib_alloc, NULL);
  luaL_openlibs(lua);
  lua_newtable(lua);
  lua_setglobal(lua, "mud");
  lua_args_init(lua, argc, argv);
  lua_descriptor_init(lua);
  lua_log_init(lua);
  lua_zmq_init(lua, zmq_pub_socket);
}

void lua_api_deinit(void) {
  lua_close(lua);
  lua = NULL;
}

lua_State* lua_api_get(void) {
  return lua;
}
