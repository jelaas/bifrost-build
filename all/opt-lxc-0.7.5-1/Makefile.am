pkginclude_HEADERS = \
		start.h \
		console.h \
		error.h \
		monitor.h \
		utils.h \
		namespace.h \
		caps.h \
		lxc.h \
		cgroup.h \
		conf.h \
		list.h \
		log.h \
		state.h
RANLIB = true
adir=$(libdir)
# use PROGRAMS to avoid complains from automake
noinst_LIBRARIES = liblxc.a

liblxc_a_SOURCES = \
	arguments.c arguments.h \
	commands.c commands.h \
	start.c start.h \
	stop.c \
	monitor.c monitor.h \
	console.c \
	freezer.c \
	checkpoint.c \
	restart.c \
	error.h error.c \
	parse.c parse.h \
	cgroup.c cgroup.h \
	lxc.h \
	utils.c utils.h \
	sync.c sync.h \
	namespace.h namespace.c \
	conf.c conf.h \
	confile.c confile.h \
	list.h \
	state.c state.h \
	log.c log.h \
	\
	network.c network.h \
        nl.c nl.h \
        rtnl.c rtnl.h \
        genl.c genl.h \
	\
	caps.c caps.h \
	mainloop.c mainloop.h \
	af_unix.c af_unix.h \
	\
	utmp.c utmp.h

AM_CFLAGS=-I$(top_srcdir)/src

bin_SCRIPTS = \
	lxc-ps \
	lxc-netstat \
	lxc-ls \
	lxc-checkconfig \
	lxc-setcap \
	lxc-setuid \
	lxc-version \
	lxc-create \
	lxc-clone \
	lxc-destroy

bin_PROGRAMS = \
	lxc-attach \
	lxc-unshare \
	lxc-stop \
	lxc-start \
	lxc-execute \
	lxc-monitor \
	lxc-wait \
	lxc-console \
	lxc-freeze \
	lxc-info \
	lxc-cgroup \
	lxc-unfreeze \
	lxc-checkpoint \
	lxc-restart \
	lxc-kill

pkglib_PROGRAMS = \
	lxc-init

AM_LDFLAGS=
LDADD=liblxc.a -lutil @CAP_LIBS@

lxc_attach_SOURCES = lxc_attach.c
lxc_cgroup_SOURCES = lxc_cgroup.c
lxc_checkpoint_SOURCES = lxc_checkpoint.c
lxc_console_SOURCES = lxc_console.c
lxc_execute_SOURCES = lxc_execute.c
lxc_freeze_SOURCES = lxc_freeze.c
lxc_info_SOURCES = lxc_info.c
lxc_init_SOURCES = lxc_init.c
lxc_monitor_SOURCES = lxc_monitor.c
lxc_restart_SOURCES = lxc_restart.c
lxc_start_SOURCES = lxc_start.c
lxc_stop_SOURCES = lxc_stop.c
lxc_unfreeze_SOURCES = lxc_unfreeze.c
lxc_unshare_SOURCES = lxc_unshare.c
lxc_wait_SOURCES = lxc_wait.c
lxc_kill_SOURCES = lxc_kill.c

install-exec-local: 

uninstall-local:
	$(RM) $(DESTDIR)$(libdir)/liblxc.a

namespace.c: setns.h

setns.h:
	-$(CC) $(CPPFLAGS) -M -MT$@ $(LINUX_DIR)/arch/$(LINUX_SRCARCH)/include/asm/unistd.h >setns.P
	-$(CPP) $(CPPFLAGS) -dM $(LINUX_DIR)/arch/$(LINUX_SRCARCH)/include/asm/unistd.h |grep setns > $@

clean-local:
	$(RM) setns.h setns.P

-include setns.P
