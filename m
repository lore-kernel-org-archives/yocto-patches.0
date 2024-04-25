Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
 by mx.groups.io with SMTP id smtpd.web10.7099.1714010179833098590
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Apr 2024 18:56:20 -0700
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61b62005f38so4848997b3.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Apr 2024 18:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1714010179; x=1714614979; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lo3VrH1eB7IPKd6wl1snllhbHPHJbfm2rvQ+ZkvfkyU=;
        b=wEMdQb5HitM7u7fCTW981aK784WmcP1dYLnWo97ErMmPnN8nhwoR2uSCkyoCpXy/K3
         J0HSjp6rD67fYVgYuCWy0gPL1zJkUgXwAdtDMjZJAQoGLx1xgw5EAuv5Fk8nq1E7rajC
         OKdq3Iz9qRfJ5k4jOuXJ4FHjbk6TjxLxaTpWcSjCTTzG+oC2I6D67XFYKV8rGuNndbXD
         r45jGG5ybQ3E1ACGCe8GcMNeyFr8j7jOVG9kUaTAj+UGR1/zU6AM6cpFmMANMh5qeBs0
         /hHme6fVpVHkQLiR92ysZVxwNGprlfv3/z7HcfkWwIDBF2MU5MoWbutbXchN1tL3yaJt
         EKTw==
MIME-Version: 1.0
References: <20240425014728.4070856-1-changqing.li@windriver.com>
In-Reply-To: <20240425014728.4070856-1-changqing.li@windriver.com>
From: "Anibal Limon" <anibal@limonsoftware.com>
Date: Wed, 24 Apr 2024 19:56:08 -0600
Message-ID: <CAOU5ZMvLYuL9eZp0_FzhGCJw+S6tUVxT5DMx38NYRUaq6mdFLA@mail.gmail.com>
Subject: Re: [PATCH V2] utils.c: fix pty setup
Content-Type: multipart/alternative; boundary="000000000000da8dcf0616e21702"
To: changqing.li@windriver.com
Cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
List-ID: <yocto-patches.lists.yoctoproject.org>

--000000000000da8dcf0616e21702
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Changqing,

I will review it, thanks for the patch!,

Regards!.
Anibal

On Wed, Apr 24, 2024 at 7:47=E2=80=AFPM <changqing.li@windriver.com> wrote:

> From: Changqing Li <changqing.li@windriver.com>
>
> subcase test_tevent_trace will fail if run libtevent-ptest with
> ptest-runner, but if run directly, the subcase can successfully.
>
> The failure related to how pty is setup:
> In child progress, after close(0), the master pty will use 0 as file
> descriptors, and then master pty is attched as child stdin, and slave
> pty will also be closed by func close_fds. This will make epoll_wait
> will get signal EPOLLHUP, then test failed.
>
> Refer:
> epoll_wait(3, [{events=3DEPOLLOUT|EPOLLHUP, data=3D{u32=3D2625883648,
> u64=3D94496201362944}}], 1, 30000) =3D 1
>
> lrwx------ 1 root root 64 Apr 23 01:08 0 -> /dev/ptmx
> l-wx------ 1 root root 64 Apr 23 01:08 1 -> 'pipe:[4261]'
> l-wx------ 1 root root 64 Apr 23 01:08 2 -> 'pipe:[4261]'
>
> To fix this:
> 1. Open master pty in parent process
> 2. Attach slave pty to child stdin
> 3. Remove detaching controlling tty from parent process
> 4. Remove seting process groupid for child process
>
> Refer:
> lrwx------ 1 root root 64 Apr 23 07:35 0 -> /dev/pts/0
> l-wx------ 1 root root 64 Apr 23 07:35 1 -> 'pipe:[37001]'
> l-wx------ 1 root root 64 Apr 23 07:35 2 -> 'pipe:[37001]'
>
> Signed-off-by: Changqing Li <changqing.li@windriver.com>
> ---
>  utils.c | 67 ++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 38 insertions(+), 29 deletions(-)
>
> diff --git a/utils.c b/utils.c
> index 46918f4..6b3a492 100644
> --- a/utils.c
> +++ b/utils.c
> @@ -341,25 +341,31 @@ run_child(char *run_ptest, int fd_stdout, int
> fd_stderr)
>         /* exit(1); not needed? */
>  }
>
> +/* Returns an integer.
> + * If it returns < 0, an error has occurred.
> + * Otherwise, return 0 means successfully
> + * fp should be writable, likely stdout/err.
> + */
> +static int
> +setup_master_pty(int* pty_master, int* pty_slave, char*pty_name, FILE
> *fp) {
> +       if (openpty(pty_master, pty_slave, pty_name, NULL, NULL) < 0) {
> +               fprintf(fp, "ERROR: openpty() failed with: %s.\n",
> strerror(errno));
> +               return -1;
> +       }
> +       return 0;
> +}
> +
>  /* Returns an integer file descriptor.
>   * If it returns < 0, an error has occurred.
>   * Otherwise, it has returned the slave pty file descriptor.
>   * fp should be writable, likely stdout/err.
>   */
>  static int
> -setup_slave_pty(FILE *fp) {
> -       int pty_master =3D -1;
> -       int pty_slave =3D -1;
> -       char pty_name[256];
> +setup_slave_pty(char* pty_name, FILE *fp) {
>         struct group *gptr;
>         gid_t gid;
>         int slave =3D -1;
>
> -       if (openpty(&pty_master, &pty_slave, pty_name, NULL, NULL) < 0) {
> -               fprintf(fp, "ERROR: openpty() failed with: %s.\n",
> strerror(errno));
> -               return -1;
> -       }
> -
>         if ((gptr =3D getgrnam(pty_name)) !=3D 0) {
>                 gid =3D gptr->gr_gid;
>         } else {
> @@ -384,9 +390,9 @@ setup_slave_pty(FILE *fp) {
>         if ((slave =3D open(pty_name, O_RDWR)) =3D=3D -1) {
>                 fprintf(fp, "ERROR: open() failed with: %s.\n",
> strerror(errno));
>         }
> -       return (slave);
> -}
>
> +       return slave;
> +}
>
>  int
>  run_ptests(struct ptest_list *head, const struct ptest_options opts,
> @@ -406,16 +412,13 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>
>         do
>         {
> -               if (isatty(0) && ioctl(0, TIOCNOTTY) =3D=3D -1) {
> -                       fprintf(fp, "ERROR: Unable to detach from
> controlling tty, %s\n", strerror(errno));
> -               }
> -
> -
>                 fprintf(fp, "START: %s\n", progname);
>                 PTEST_LIST_ITERATE_START(head, p)
>                         int pipefd_stdout[2] =3D {-1, -1};
>                         int pipefd_stderr[2] =3D {-1, -1};
> -                       int pgid =3D -1;
> +                       int pty_master =3D -1;
> +                       int pty_slave =3D -1;
> +                       char pty_name[256] =3D {0};
>
>                         if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
>                                 rc =3D -1;
> @@ -435,8 +438,9 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>                         }
>                         dirname(ptest_dir);
>
> -                       if ((pgid =3D getpgid(0)) =3D=3D -1) {
> -                               fprintf(fp, "ERROR: getpgid() failed,
> %s\n", strerror(errno));
> +                       if (setup_master_pty(&pty_master, &pty_slave,
> pty_name, fp) < 0) {
> +                               fprintf(fp, "ERROR: setup_master_pty
> failed, %s\n", strerror(errno));
> +                               break;
>                         }
>
>                         pid_t child =3D fork();
> @@ -447,25 +451,32 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>                         } else if (child =3D=3D 0) {
>                                 int slave;
>
> -                               close(0);
>                                 /* Close read ends of the pipe */
>                                 do_close(&pipefd_stdout[PIPE_READ]);
>                                 do_close(&pipefd_stderr[PIPE_READ]);
> +                               do_close(&pty_master);
>
> -                               if ((slave =3D setup_slave_pty(fp)) < 0) =
{
> +                               if ((slave =3D setup_slave_pty(pty_name,
> fp)) < 0) {
>                                         fprintf(fp, "ERROR: could not
> setup pty (%d).", slave);
>                                 }
> -                               if (setpgid(0,pgid) =3D=3D -1) {
> -                                       fprintf(fp, "ERROR: setpgid()
> failed, %s\n", strerror(errno));
> -                               }
>
>                                 if (setsid() =3D=3D  -1) {
>                                         fprintf(fp, "ERROR: setsid()
> failed, %s\n", strerror(errno));
>                                 }
>
> -                               if (ioctl(0, TIOCSCTTY, NULL) =3D=3D -1) =
{
> +                               if (ioctl(slave, TIOCSCTTY, NULL) =3D=3D =
-1) {
>                                         fprintf(fp, "ERROR: Unable to
> attach to controlling tty, %s\n", strerror(errno));
>                                 }
> +                               if (slave > 2) {
> +                                       close(slave);
> +                               }
> +
> +                               if (dup2(pty_slave, STDIN_FILENO) < 0) {
> +                                       fprintf(fp, "ERROR: Unable to dup
> slave pty to stdin, %s\n", strerror(errno));
> +                               }
> +                               if (pty_slave > 2) {
> +                                       close(pty_slave);
> +                               }
>
>                                 if (chdir(ptest_dir) =3D=3D -1) {
>                                         fprintf(fp, "ERROR: Unable to
> chdir(%s), %s\n", ptest_dir, strerror(errno));
> @@ -481,10 +492,6 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>                                 do_close(&pipefd_stdout[PIPE_WRITE]);
>                                 do_close(&pipefd_stderr[PIPE_WRITE]);
>
> -                               if (setpgid(child, pgid) =3D=3D -1) {
> -                                       fprintf(fp, "ERROR: setpgid()
> failed, %s\n", strerror(errno));
> -                               }
> -
>                                 time_t start_time=3D time(NULL);
>                                 fprintf(fp, "%s\n", get_stime(stime,
> GET_STIME_BUF_SIZE, start_time));
>                                 fprintf(fp, "BEGIN: %s\n", ptest_dir);
> @@ -608,6 +615,8 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>                         do_close(&pipefd_stdout[PIPE_WRITE]);
>                         do_close(&pipefd_stderr[PIPE_READ]);
>                         do_close(&pipefd_stderr[PIPE_WRITE]);
> +                       do_close(&pty_master);
> +                       do_close(&pty_slave);
>
>                         fflush(fp);
>                         fflush(fp_stderr);
> --
> 2.25.1
>
>

--000000000000da8dcf0616e21702
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgQ2hhbmdxaW5nLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSB3aWxsIHJl
dmlldyBpdCwgdGhhbmtzIGZvciB0aGUgcGF0Y2ghLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
UmVnYXJkcyEuPC9kaXY+PGRpdj5BbmliYWw8L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21h
aWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBXZWQsIEFwciAy
NCwgMjAyNCBhdCA3OjQ34oCvUE0gJmx0OzxhIGhyZWY9Im1haWx0bzpjaGFuZ3FpbmcubGlAd2lu
ZHJpdmVyLmNvbSI+Y2hhbmdxaW5nLmxpQHdpbmRyaXZlci5jb208L2E+Jmd0OyB3cm90ZTo8YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPkZyb206IENoYW5ncWluZyBMaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNoYW5n
cWluZy5saUB3aW5kcml2ZXIuY29tIiB0YXJnZXQ9Il9ibGFuayI+Y2hhbmdxaW5nLmxpQHdpbmRy
aXZlci5jb208L2E+Jmd0Ozxicj4NCjxicj4NCnN1YmNhc2UgdGVzdF90ZXZlbnRfdHJhY2Ugd2ls
bCBmYWlsIGlmIHJ1biBsaWJ0ZXZlbnQtcHRlc3Qgd2l0aDxicj4NCnB0ZXN0LXJ1bm5lciwgYnV0
IGlmIHJ1biBkaXJlY3RseSwgdGhlIHN1YmNhc2UgY2FuIHN1Y2Nlc3NmdWxseS48YnI+DQo8YnI+
DQpUaGUgZmFpbHVyZSByZWxhdGVkIHRvIGhvdyBwdHkgaXMgc2V0dXA6PGJyPg0KSW4gY2hpbGQg
cHJvZ3Jlc3MsIGFmdGVyIGNsb3NlKDApLCB0aGUgbWFzdGVyIHB0eSB3aWxsIHVzZSAwIGFzIGZp
bGU8YnI+DQpkZXNjcmlwdG9ycywgYW5kIHRoZW4gbWFzdGVyIHB0eSBpcyBhdHRjaGVkIGFzIGNo
aWxkIHN0ZGluLCBhbmQgc2xhdmU8YnI+DQpwdHkgd2lsbCBhbHNvIGJlIGNsb3NlZCBieSBmdW5j
IGNsb3NlX2Zkcy4gVGhpcyB3aWxsIG1ha2UgZXBvbGxfd2FpdDxicj4NCndpbGwgZ2V0IHNpZ25h
bCBFUE9MTEhVUCwgdGhlbiB0ZXN0IGZhaWxlZC48YnI+DQo8YnI+DQpSZWZlcjo8YnI+DQplcG9s
bF93YWl0KDMsIFt7ZXZlbnRzPUVQT0xMT1VUfEVQT0xMSFVQLCBkYXRhPXt1MzI9MjYyNTg4MzY0
OCwgdTY0PTk0NDk2MjAxMzYyOTQ0fX1dLCAxLCAzMDAwMCkgPSAxPGJyPg0KPGJyPg0KbHJ3eC0t
LS0tLSAxIHJvb3Qgcm9vdCA2NCBBcHIgMjMgMDE6MDggMCAtJmd0OyAvZGV2L3B0bXg8YnI+DQps
LXd4LS0tLS0tIDEgcm9vdCByb290IDY0IEFwciAyMyAwMTowOCAxIC0mZ3Q7ICYjMzk7cGlwZTpb
NDI2MV0mIzM5Ozxicj4NCmwtd3gtLS0tLS0gMSByb290IHJvb3QgNjQgQXByIDIzIDAxOjA4IDIg
LSZndDsgJiMzOTtwaXBlOls0MjYxXSYjMzk7PGJyPg0KPGJyPg0KVG8gZml4IHRoaXM6PGJyPg0K
MS4gT3BlbiBtYXN0ZXIgcHR5IGluIHBhcmVudCBwcm9jZXNzPGJyPg0KMi4gQXR0YWNoIHNsYXZl
IHB0eSB0byBjaGlsZCBzdGRpbjxicj4NCjMuIFJlbW92ZSBkZXRhY2hpbmcgY29udHJvbGxpbmcg
dHR5IGZyb20gcGFyZW50IHByb2Nlc3M8YnI+DQo0LiBSZW1vdmUgc2V0aW5nIHByb2Nlc3MgZ3Jv
dXBpZCBmb3IgY2hpbGQgcHJvY2Vzczxicj4NCjxicj4NClJlZmVyOjxicj4NCmxyd3gtLS0tLS0g
MSByb290IHJvb3QgNjQgQXByIDIzIDA3OjM1IDAgLSZndDsgL2Rldi9wdHMvMDxicj4NCmwtd3gt
LS0tLS0gMSByb290IHJvb3QgNjQgQXByIDIzIDA3OjM1IDEgLSZndDsgJiMzOTtwaXBlOlszNzAw
MV0mIzM5Ozxicj4NCmwtd3gtLS0tLS0gMSByb290IHJvb3QgNjQgQXByIDIzIDA3OjM1IDIgLSZn
dDsgJiMzOTtwaXBlOlszNzAwMV0mIzM5Ozxicj4NCjxicj4NClNpZ25lZC1vZmYtYnk6IENoYW5n
cWluZyBMaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNoYW5ncWluZy5saUB3aW5kcml2ZXIuY29tIiB0
YXJnZXQ9Il9ibGFuayI+Y2hhbmdxaW5nLmxpQHdpbmRyaXZlci5jb208L2E+Jmd0Ozxicj4NCi0t
LTxicj4NCsKgdXRpbHMuYyB8IDY3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4NCsKgMSBmaWxlIGNoYW5nZWQsIDM4IGluc2VydGlv
bnMoKyksIDI5IGRlbGV0aW9ucygtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS91dGlscy5jIGIv
dXRpbHMuYzxicj4NCmluZGV4IDQ2OTE4ZjQuLjZiM2E0OTIgMTAwNjQ0PGJyPg0KLS0tIGEvdXRp
bHMuYzxicj4NCisrKyBiL3V0aWxzLmM8YnI+DQpAQCAtMzQxLDI1ICszNDEsMzEgQEAgcnVuX2No
aWxkKGNoYXIgKnJ1bl9wdGVzdCwgaW50IGZkX3N0ZG91dCwgaW50IGZkX3N0ZGVycik8YnI+DQrC
oCDCoCDCoCDCoCAvKiBleGl0KDEpOyBub3QgbmVlZGVkPyAqLzxicj4NCsKgfTxicj4NCjxicj4N
CisvKiBSZXR1cm5zIGFuIGludGVnZXIuPGJyPg0KKyAqIElmIGl0IHJldHVybnMgJmx0OyAwLCBh
biBlcnJvciBoYXMgb2NjdXJyZWQuPGJyPg0KKyAqIE90aGVyd2lzZSwgcmV0dXJuIDAgbWVhbnMg
c3VjY2Vzc2Z1bGx5PGJyPg0KKyAqIGZwIHNob3VsZCBiZSB3cml0YWJsZSwgbGlrZWx5IHN0ZG91
dC9lcnIuPGJyPg0KKyAqLzxicj4NCitzdGF0aWMgaW50PGJyPg0KK3NldHVwX21hc3Rlcl9wdHko
aW50KiBwdHlfbWFzdGVyLCBpbnQqIHB0eV9zbGF2ZSwgY2hhcipwdHlfbmFtZSwgRklMRSAqZnAp
IHs8YnI+DQorwqAgwqAgwqAgwqBpZiAob3BlbnB0eShwdHlfbWFzdGVyLCBwdHlfc2xhdmUsIHB0
eV9uYW1lLCBOVUxMLCBOVUxMKSAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogb3BlbnB0eSgpIGZhaWxlZCB3aXRoOiAlcy5cbiZx
dW90Oywgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gLTE7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoHJldHVybiAwOzxicj4N
Cit9PGJyPg0KKzxicj4NCsKgLyogUmV0dXJucyBhbiBpbnRlZ2VyIGZpbGUgZGVzY3JpcHRvci48
YnI+DQrCoCAqIElmIGl0IHJldHVybnMgJmx0OyAwLCBhbiBlcnJvciBoYXMgb2NjdXJyZWQuPGJy
Pg0KwqAgKiBPdGhlcndpc2UsIGl0IGhhcyByZXR1cm5lZCB0aGUgc2xhdmUgcHR5IGZpbGUgZGVz
Y3JpcHRvci48YnI+DQrCoCAqIGZwIHNob3VsZCBiZSB3cml0YWJsZSwgbGlrZWx5IHN0ZG91dC9l
cnIuPGJyPg0KwqAgKi88YnI+DQrCoHN0YXRpYyBpbnQ8YnI+DQotc2V0dXBfc2xhdmVfcHR5KEZJ
TEUgKmZwKSB7PGJyPg0KLcKgIMKgIMKgIMKgaW50IHB0eV9tYXN0ZXIgPSAtMTs8YnI+DQotwqAg
wqAgwqAgwqBpbnQgcHR5X3NsYXZlID0gLTE7PGJyPg0KLcKgIMKgIMKgIMKgY2hhciBwdHlfbmFt
ZVsyNTZdOzxicj4NCitzZXR1cF9zbGF2ZV9wdHkoY2hhciogcHR5X25hbWUsIEZJTEUgKmZwKSB7
PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGdyb3VwICpncHRyOzxicj4NCsKgIMKgIMKgIMKgIGdp
ZF90IGdpZDs8YnI+DQrCoCDCoCDCoCDCoCBpbnQgc2xhdmUgPSAtMTs8YnI+DQo8YnI+DQotwqAg
wqAgwqAgwqBpZiAob3BlbnB0eSgmYW1wO3B0eV9tYXN0ZXIsICZhbXA7cHR5X3NsYXZlLCBwdHlf
bmFtZSwgTlVMTCwgTlVMTCkgJmx0OyAwKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IG9wZW5wdHkoKSBmYWlsZWQgd2l0aDogJXMuXG4mcXVv
dDssIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IC0xOzxicj4NCi3CoCDCoCDCoCDCoH08YnI+DQotPGJyPg0KwqAgwqAgwqAgwqAgaWYgKChncHRy
ID0gZ2V0Z3JuYW0ocHR5X25hbWUpKSAhPSAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZ2lkID0gZ3B0ci0mZ3Q7Z3JfZ2lkOzxicj4NCsKgIMKgIMKgIMKgIH0gZWxzZSB7PGJyPg0K
QEAgLTM4NCw5ICszOTAsOSBAQCBzZXR1cF9zbGF2ZV9wdHkoRklMRSAqZnApIHs8YnI+DQrCoCDC
oCDCoCDCoCBpZiAoKHNsYXZlID0gb3BlbihwdHlfbmFtZSwgT19SRFdSKSkgPT0gLTEpIHs8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogb3Blbigp
IGZhaWxlZCB3aXRoOiAlcy5cbiZxdW90Oywgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQrCoCDCoCDC
oCDCoCB9PGJyPg0KLcKgIMKgIMKgIMKgcmV0dXJuIChzbGF2ZSk7PGJyPg0KLX08YnI+DQo8YnI+
DQorwqAgwqAgwqAgwqByZXR1cm4gc2xhdmU7PGJyPg0KK308YnI+DQo8YnI+DQrCoGludDxicj4N
CsKgcnVuX3B0ZXN0cyhzdHJ1Y3QgcHRlc3RfbGlzdCAqaGVhZCwgY29uc3Qgc3RydWN0IHB0ZXN0
X29wdGlvbnMgb3B0cyw8YnI+DQpAQCAtNDA2LDE2ICs0MTIsMTMgQEAgcnVuX3B0ZXN0cyhzdHJ1
Y3QgcHRlc3RfbGlzdCAqaGVhZCwgY29uc3Qgc3RydWN0IHB0ZXN0X29wdGlvbnMgb3B0cyw8YnI+
DQo8YnI+DQrCoCDCoCDCoCDCoCBkbzxicj4NCsKgIMKgIMKgIMKgIHs8YnI+DQotwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoaXNhdHR5KDApICZhbXA7JmFtcDsgaW9jdGwoMCwgVElPQ05PVFRZ
KSA9PSAtMSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmlu
dGYoZnAsICZxdW90O0VSUk9SOiBVbmFibGUgdG8gZGV0YWNoIGZyb20gY29udHJvbGxpbmcgdHR5
LCAlc1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+DQotPGJyPg0KLTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYo
ZnAsICZxdW90O1NUQVJUOiAlc1xuJnF1b3Q7LCBwcm9nbmFtZSk7PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgUFRFU1RfTElTVF9JVEVSQVRFX1NUQVJUKGhlYWQsIHApPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50IHBpcGVmZF9zdGRvdXRbMl0gPSB7LTEs
IC0xfTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQgcGlwZWZk
X3N0ZGVyclsyXSA9IHstMSwgLTF9Ozxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGludCBwZ2lkID0gLTE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaW50IHB0eV9tYXN0ZXIgPSAtMTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpbnQgcHR5X3NsYXZlID0gLTE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY2hhciBwdHlfbmFtZVsyNTZdID0gezB9Ozxicj4NCjxicj4NCsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChwaXBlMihwaXBlZmRfc3Rkb3V0LCAw
KSA9PSAtMSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHJjID0gLTE7PGJyPg0KQEAgLTQzNSw4ICs0MzgsOSBAQCBydW5fcHRlc3RzKHN0cnVj
dCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdCBzdHJ1Y3QgcHRlc3Rfb3B0aW9ucyBvcHRzLDxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaXJuYW1lKHB0ZXN0X2Rpcik7PGJyPg0KPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKChwZ2lkID0gZ2V0cGdpZCgwKSkg
PT0gLTEpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogZ2V0cGdpZCgpIGZhaWxlZCwgJXNcbiZxdW90
Oywgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAoc2V0dXBfbWFzdGVyX3B0eSgmYW1wO3B0eV9tYXN0ZXIsICZhbXA7cHR5X3NsYXZl
LCBwdHlfbmFtZSwgZnApICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICZxdW90O0VSUk9SOiBzZXR1cF9tYXN0
ZXJfcHR5IGZhaWxlZCwgJXNcbiZxdW90Oywgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcGlkX3QgY2hpbGQgPSBmb3JrKCk7PGJyPg0KQEAgLTQ0
NywyNSArNDUxLDMyIEBAIHJ1bl9wdGVzdHMoc3RydWN0IHB0ZXN0X2xpc3QgKmhlYWQsIGNvbnN0
IHN0cnVjdCBwdGVzdF9vcHRpb25zIG9wdHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgfSBlbHNlIGlmIChjaGlsZCA9PSAwKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50IHNsYXZlOzxicj4NCjxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsb3NlKDApOzxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIENs
b3NlIHJlYWQgZW5kcyBvZiB0aGUgcGlwZSAqLzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRvX2Nsb3NlKCZhbXA7cGlwZWZkX3N0ZG91dFtQSVBF
X1JFQURdKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBkb19jbG9zZSgmYW1wO3BpcGVmZF9zdGRlcnJbUElQRV9SRUFEXSk7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZG9fY2xvc2UoJmFtcDtw
dHlfbWFzdGVyKTs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAoKHNsYXZlID0gc2V0dXBfc2xhdmVfcHR5KGZwKSkgJmx0OyAwKSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYg
KChzbGF2ZSA9IHNldHVwX3NsYXZlX3B0eShwdHlfbmFtZSwgZnApKSAmbHQ7IDApIHs8YnI+DQrC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogY291bGQgbm90IHNldHVwIHB0eSAoJWQpLiZxdW90
Oywgc2xhdmUpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAoc2V0cGdpZCgwLHBnaWQpID09IC0xKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihmcCwgJnF1
b3Q7RVJST1I6IHNldHBnaWQoKSBmYWlsZWQsICVzXG4mcXVvdDssIHN0cmVycm9yKGVycm5vKSk7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxi
cj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGlmIChzZXRzaWQoKSA9PcKgIC0xKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6
IHNldHNpZCgpIGZhaWxlZCwgJXNcbiZxdW90Oywgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGlvY3Rs
KDAsIFRJT0NTQ1RUWSwgTlVMTCkgPT0gLTEpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoaW9jdGwoc2xhdmUsIFRJT0NTQ1RUWSwgTlVM
TCkgPT0gLTEpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogVW5hYmxlIHRvIGF0
dGFjaCB0byBjb250cm9sbGluZyB0dHksICVzXG4mcXVvdDssIHN0cmVycm9yKGVycm5vKSk7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzbGF2
ZSAmZ3Q7IDIpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9zZShzbGF2ZSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZHVwMihwdHlfc2xhdmUsIFNU
RElOX0ZJTEVOTykgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IFVu
YWJsZSB0byBkdXAgc2xhdmUgcHR5IHRvIHN0ZGluLCAlc1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJu
bykpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAocHR5X3NsYXZlICZndDsgMikgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNsb3NlKHB0eV9zbGF2ZSk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCjxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChjaGRp
cihwdGVzdF9kaXIpID09IC0xKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IFVu
YWJsZSB0byBjaGRpciglcyksICVzXG4mcXVvdDssIHB0ZXN0X2Rpciwgc3RyZXJyb3IoZXJybm8p
KTs8YnI+DQpAQCAtNDgxLDEwICs0OTIsNiBAQCBydW5fcHRlc3RzKHN0cnVjdCBwdGVzdF9saXN0
ICpoZWFkLCBjb25zdCBzdHJ1Y3QgcHRlc3Rfb3B0aW9ucyBvcHRzLDxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRvX2Nsb3NlKCZhbXA7cGlwZWZk
X3N0ZG91dFtQSVBFX1dSSVRFXSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZG9fY2xvc2UoJmFtcDtwaXBlZmRfc3RkZXJyW1BJUEVfV1JJVEVd
KTs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpZiAoc2V0cGdpZChjaGlsZCwgcGdpZCkgPT0gLTEpIHs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZw
LCAmcXVvdDtFUlJPUjogc2V0cGdpZCgpIGZhaWxlZCwgJXNcbiZxdW90Oywgc3RyZXJyb3IoZXJy
bm8pKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB9PGJyPg0KLTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHRpbWVfdCBzdGFydF90aW1lPSB0aW1lKE5VTEwpOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoZnAsICZxdW90OyVzXG4m
cXVvdDssIGdldF9zdGltZShzdGltZSwgR0VUX1NUSU1FX0JVRl9TSVpFLCBzdGFydF90aW1lKSk7
PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnBy
aW50ZihmcCwgJnF1b3Q7QkVHSU46ICVzXG4mcXVvdDssIHB0ZXN0X2Rpcik7PGJyPg0KQEAgLTYw
OCw2ICs2MTUsOCBAQCBydW5fcHRlc3RzKHN0cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdCBz
dHJ1Y3QgcHRlc3Rfb3B0aW9ucyBvcHRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGRvX2Nsb3NlKCZhbXA7cGlwZWZkX3N0ZG91dFtQSVBFX1dSSVRFXSk7PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZG9fY2xvc2UoJmFtcDtwaXBlZmRf
c3RkZXJyW1BJUEVfUkVBRF0pOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGRvX2Nsb3NlKCZhbXA7cGlwZWZkX3N0ZGVycltQSVBFX1dSSVRFXSk7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZG9fY2xvc2UoJmFtcDtwdHlfbWFzdGVyKTs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkb19jbG9zZSgmYW1wO3B0
eV9zbGF2ZSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZmZsdXNoKGZwKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmZmx1
c2goZnBfc3RkZXJyKTs8YnI+DQotLSA8YnI+DQoyLjI1LjE8YnI+DQo8YnI+DQo8L2Jsb2NrcXVv
dGU+PC9kaXY+DQo=

--000000000000da8dcf0616e21702--
