#ifdef HAVE_CONFIG_H
#include <config.h>
#endif
#include "options.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "arg_parse.h"
#include "log.h"

#define DEFAULT_PORT "5000"
#define DEFAULT_PULSE_LENGTH (100 * 1000) /* in microseconds */
#define DEFAULT_ZMQ_PUB_ENDPOINT "tcp://*:5001"
#define DEFAULT_ZMQ_REP_ENDPOINT "tcp://*:5002"

static gboolean file_logging = TRUE;
static gchar* port = NULL;
static gint pulse_length = DEFAULT_PULSE_LENGTH;
static gchar* zmq_pub_endpoint = NULL;
static gchar* zmq_rep_endpoint = NULL;

static void options_on_flag(const gchar* flagname,
                            gboolean value,
                            gpointer user_data) {
  (void) user_data; /* Not used. */
  if (strcmp(flagname, "file-logging") == 0) {
    file_logging = value;
  } else if (strcmp(flagname, "help") == 0 && value) {
    puts("MudCore Command Line:\n"
         "=====================\n"
         "  -(no-)file-logging         (dis)able logging to file\n"
         "  -help                      print this message, then exit\n"
         "  -log-level=LEVEL           set logging level to one of:\n"
         "                             debug, info, warn, error or fatal\n"
         "  -port=PORT                "
         " port for the main socket [" DEFAULT_PORT "]\n"
         "  -pulse-length=LENGTH      "
         " length of each pulse in usec [" G_STRINGIFY(DEFAULT_PULSE_RATE) "]\n"
         "  -zmq-pub-endpoint=ENDPOINT"
         " ZeroMQ endpoint for pub socket [" DEFAULT_ZMQ_PUB_ENDPOINT "]\n"
         "  -zmq-rep-endpoint=ENDPOINT"
         " ZeroMQ endpoint for rep socket [" DEFAULT_ZMQ_REP_ENDPOINT "]\n"
         "\n"
         "Lua code may use other flags not documented here.");
    exit(EXIT_SUCCESS);
  }
}

static void options_on_option(const gchar* name,
                              const gchar* value,
                              gpointer user_data) {
  (void) user_data; /* Not used. */
  if (strcmp(name, "log-level") == 0) {
    for (enum log_level level = LOG_LEVEL_DEBUG;
         level <= LOG_LEVEL_FATAL;
         level++) {
      if (strcmp(value, log_level_to_string(level)) == 0) {
        log_set_level(level);
        return;
      }
    }
    printf("Unknown log level \"%s\"\n", value);
    exit(EXIT_FAILURE);
  } else if (strcmp(name, "port") == 0) {
    g_free(port);
    port = g_strdup(value);
  } else if (strcmp(name, "zmq-pub-endpoint") == 0) {
    g_free(zmq_pub_endpoint);
    zmq_pub_endpoint = g_strdup(zmq_pub_endpoint);
  } else if (strcmp(name, "zmq-rep-endpoint") == 0) {
    g_free(zmq_rep_endpoint);
    zmq_rep_endpoint = g_strdup(zmq_rep_endpoint);
  }
}

void options_init(gint argc, gchar* argv[]) {
  port = g_strdup(DEFAULT_PORT);
  zmq_pub_endpoint = g_strdup(DEFAULT_ZMQ_PUB_ENDPOINT);
  zmq_rep_endpoint = g_strdup(DEFAULT_ZMQ_REP_ENDPOINT);
  struct arg_parse_funcs funcs = {
    .on_flag       = options_on_flag,
    .on_option     = options_on_option,
    .on_positional = NULL
  };
  arg_parse(argc, argv, &funcs, NULL);
}

void options_deinit(void) {
  g_free(port);
  g_free(zmq_pub_endpoint);
  g_free(zmq_rep_endpoint);
}

gboolean options_file_logging(void) {
  return file_logging;
}

gchar* options_port(void) {
  return port;
}

gint options_pulse_length(void) {
  return pulse_length;
}

gchar* options_zmq_pub_endpoint(void) {
  return zmq_pub_endpoint;
}

gchar* options_zmq_rep_endpoint(void) {
  return zmq_rep_endpoint;
}
