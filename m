Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C909C4345F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 22:00:11 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
 by mx.groups.io with SMTP id smtpd.web11.25.1714082409106409446
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 25 Apr 2024 15:00:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=zCuJal5Z;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.175, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-617e42a3f94so16769457b3.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1714082408; x=1714687208; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mlXIlTGgCVuBcSFySGcWfzwnkW+IDwyZYCXu9ZPFl14=;
        b=zCuJal5Z/E/lZM5t0aQ/0YIdVzy2/EpZfyBViTd5Vas7IZB+dG7kgQwaEYoaqRhxeo
         uLY25PEZuGwoZisSHjcEi3P6Qv+egdos+SSp/KCcHeIYo5kU8FlFPuN3IMAF+FDhwV9G
         YI7W0sBIa0a8vwan5Q4Dj7dICUXmxXzZZzGl9uTTOBGiAIGHjuOvcbtTTL99XmM7HYwF
         rM3P9ACE5pA330smCs8gaDf0Dx076O3mxU0ZVg+etWFB+qBLhli7eSpQAIExMze3tGUb
         QsjGKkviK3Sbq/2eqTnDtms1/GQI1W2MgNF60FKWbjJb7cUyoidmMPztiE0rn5O/HuBk
         oReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714082408; x=1714687208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlXIlTGgCVuBcSFySGcWfzwnkW+IDwyZYCXu9ZPFl14=;
        b=XBW7i60a8wZ7z/pzrAwMPn6/E3AkoNP67ageEW3jF9B9OCW8jwPM1L9XXpu6fPVj6E
         kNu6FQ7H8NVdVPlc2M6VSabuM7z98se2NAQdemQjJhve+EAP4xGkCsWeZdr3lk3Xj7/a
         S+HyDwyZYBJygpdoWrjQ51SCALGW+vfQeDYwsRl5xtYzuTsHMQcAWBIM4tRQWIJb1NGi
         1oqW+ed9jnoAP1LIu7LTQu9xQEnY5WHY2XKuaZSu0UA0FT9Nj17cvvyug6QANd/haNoS
         3NfgqhDGYD1kSQpKn0CsyWd3TxA2DIfCyQe0cAQf/xFRudVhvcUaP1Qb7K7ZanH0U+YF
         7Wdw==
X-Gm-Message-State: AOJu0YzBjNVQEAa/LjxOuPZLlhrs6VQiE7F3hjwSywaTInqgcUeKjFCA
	HGZKuUcyM51lpf3wbb0fNqQSTdFJZQLGhzxpemzBivRBAfJaJFic8zWdEKnaAhXdVvhkrqKAbY0
	Kq4tEhJ9uWJkTQUV4vLlKpUaU7kXgCixtgknrTg==
X-Google-Smtp-Source: AGHT+IHhnXs6Qr4fySYxSxDg+95eBAz2dJXdaOrp8hl8ueciczjpm5dfu+7xpUZ68OiNhKgRMBIRQJXHTm26NbAbCdU=
X-Received: by 2002:a05:690c:7241:b0:615:1125:11bf with SMTP id
 jm1-20020a05690c724100b00615112511bfmr641859ywb.52.1714082408247; Thu, 25 Apr
 2024 15:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240425014728.4070856-1-changqing.li@windriver.com>
In-Reply-To: <20240425014728.4070856-1-changqing.li@windriver.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Thu, 25 Apr 2024 15:59:57 -0600
Message-ID: <CAOU5ZMue2AZxq_7fJTVn6LEXPPXWrn-D7UFdzX43xvvJV6yQEA@mail.gmail.com>
Subject: Re: [PATCH V2] utils.c: fix pty setup
To: changqing.li@windriver.com
Cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
Content-Type: multipart/alternative; boundary="0000000000000f4fcf0616f2e9f5"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Apr 2024 22:00:11 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/67

--0000000000000f4fcf0616f2e9f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Comments below,

Thanks!,
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
>

This comes from Randy patch to ensure child tests are in the same process
group than the ptest-runner, 59381a64. Any specific reason to remove this?.


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

+                               if (slave > 2) {
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
Which is the reason to make it twice?, and also closing with slave > 2.


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
>
Removal comment up.


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

--0000000000000f4fcf0616f2e9f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+Q29tbWVudHMgYmVsb3csPC9kaXY+PGRpdiBk
aXI9Imx0ciI+PGJyPjwvZGl2PjxkaXY+VGhhbmtzISw8L2Rpdj48ZGl2PkFuaWJhbDwvZGl2Pjxi
cj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0
dHIiPk9uIFdlZCwgQXByIDI0LCAyMDI0IGF0IDc6NDfigK9QTSAmbHQ7PGEgaHJlZj0ibWFpbHRv
OmNoYW5ncWluZy5saUB3aW5kcml2ZXIuY29tIj5jaGFuZ3FpbmcubGlAd2luZHJpdmVyLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigy
MDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+RnJvbTogQ2hhbmdxaW5nIExpICZsdDs8YSBo
cmVmPSJtYWlsdG86Y2hhbmdxaW5nLmxpQHdpbmRyaXZlci5jb20iIHRhcmdldD0iX2JsYW5rIj5j
aGFuZ3FpbmcubGlAd2luZHJpdmVyLmNvbTwvYT4mZ3Q7PGJyPg0KPGJyPg0Kc3ViY2FzZSB0ZXN0
X3RldmVudF90cmFjZSB3aWxsIGZhaWwgaWYgcnVuIGxpYnRldmVudC1wdGVzdCB3aXRoPGJyPg0K
cHRlc3QtcnVubmVyLCBidXQgaWYgcnVuIGRpcmVjdGx5LCB0aGUgc3ViY2FzZSBjYW4gc3VjY2Vz
c2Z1bGx5Ljxicj4NCjxicj4NClRoZSBmYWlsdXJlIHJlbGF0ZWQgdG8gaG93IHB0eSBpcyBzZXR1
cDo8YnI+DQpJbiBjaGlsZCBwcm9ncmVzcywgYWZ0ZXIgY2xvc2UoMCksIHRoZSBtYXN0ZXIgcHR5
IHdpbGwgdXNlIDAgYXMgZmlsZTxicj4NCmRlc2NyaXB0b3JzLCBhbmQgdGhlbiBtYXN0ZXIgcHR5
IGlzIGF0dGNoZWQgYXMgY2hpbGQgc3RkaW4sIGFuZCBzbGF2ZTxicj4NCnB0eSB3aWxsIGFsc28g
YmUgY2xvc2VkIGJ5IGZ1bmMgY2xvc2VfZmRzLiBUaGlzIHdpbGwgbWFrZSBlcG9sbF93YWl0PGJy
Pg0Kd2lsbCBnZXQgc2lnbmFsIEVQT0xMSFVQLCB0aGVuIHRlc3QgZmFpbGVkLjxicj4NCjxicj4N
ClJlZmVyOjxicj4NCmVwb2xsX3dhaXQoMywgW3tldmVudHM9RVBPTExPVVR8RVBPTExIVVAsIGRh
dGE9e3UzMj0yNjI1ODgzNjQ4LCB1NjQ9OTQ0OTYyMDEzNjI5NDR9fV0sIDEsIDMwMDAwKSA9IDE8
YnI+DQo8YnI+DQpscnd4LS0tLS0tIDEgcm9vdCByb290IDY0IEFwciAyMyAwMTowOCAwIC0mZ3Q7
IC9kZXYvcHRteDxicj4NCmwtd3gtLS0tLS0gMSByb290IHJvb3QgNjQgQXByIDIzIDAxOjA4IDEg
LSZndDsgJiMzOTtwaXBlOls0MjYxXSYjMzk7PGJyPg0KbC13eC0tLS0tLSAxIHJvb3Qgcm9vdCA2
NCBBcHIgMjMgMDE6MDggMiAtJmd0OyAmIzM5O3BpcGU6WzQyNjFdJiMzOTs8YnI+DQo8YnI+DQpU
byBmaXggdGhpczo8YnI+DQoxLiBPcGVuIG1hc3RlciBwdHkgaW4gcGFyZW50IHByb2Nlc3M8YnI+
DQoyLiBBdHRhY2ggc2xhdmUgcHR5IHRvIGNoaWxkIHN0ZGluPGJyPg0KMy4gUmVtb3ZlIGRldGFj
aGluZyBjb250cm9sbGluZyB0dHkgZnJvbSBwYXJlbnQgcHJvY2Vzczxicj4NCjQuIFJlbW92ZSBz
ZXRpbmcgcHJvY2VzcyBncm91cGlkIGZvciBjaGlsZCBwcm9jZXNzPGJyPg0KPGJyPg0KUmVmZXI6
PGJyPg0KbHJ3eC0tLS0tLSAxIHJvb3Qgcm9vdCA2NCBBcHIgMjMgMDc6MzUgMCAtJmd0OyAvZGV2
L3B0cy8wPGJyPg0KbC13eC0tLS0tLSAxIHJvb3Qgcm9vdCA2NCBBcHIgMjMgMDc6MzUgMSAtJmd0
OyAmIzM5O3BpcGU6WzM3MDAxXSYjMzk7PGJyPg0KbC13eC0tLS0tLSAxIHJvb3Qgcm9vdCA2NCBB
cHIgMjMgMDc6MzUgMiAtJmd0OyAmIzM5O3BpcGU6WzM3MDAxXSYjMzk7PGJyPg0KPGJyPg0KU2ln
bmVkLW9mZi1ieTogQ2hhbmdxaW5nIExpICZsdDs8YSBocmVmPSJtYWlsdG86Y2hhbmdxaW5nLmxp
QHdpbmRyaXZlci5jb20iIHRhcmdldD0iX2JsYW5rIj5jaGFuZ3FpbmcubGlAd2luZHJpdmVyLmNv
bTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0KwqB1dGlscy5jIHwgNjcgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPg0KwqAxIGZpbGUgY2hh
bmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlmZiAt
LWdpdCBhL3V0aWxzLmMgYi91dGlscy5jPGJyPg0KaW5kZXggNDY5MThmNC4uNmIzYTQ5MiAxMDA2
NDQ8YnI+DQotLS0gYS91dGlscy5jPGJyPg0KKysrIGIvdXRpbHMuYzxicj4NCkBAIC0zNDEsMjUg
KzM0MSwzMSBAQCBydW5fY2hpbGQoY2hhciAqcnVuX3B0ZXN0LCBpbnQgZmRfc3Rkb3V0LCBpbnQg
ZmRfc3RkZXJyKTxicj4NCsKgIMKgIMKgIMKgIC8qIGV4aXQoMSk7IG5vdCBuZWVkZWQ/ICovPGJy
Pg0KwqB9PGJyPg0KPGJyPg0KKy8qIFJldHVybnMgYW4gaW50ZWdlci48YnI+DQorICogSWYgaXQg
cmV0dXJucyAmbHQ7IDAsIGFuIGVycm9yIGhhcyBvY2N1cnJlZC48YnI+DQorICogT3RoZXJ3aXNl
LCByZXR1cm4gMCBtZWFucyBzdWNjZXNzZnVsbHk8YnI+DQorICogZnAgc2hvdWxkIGJlIHdyaXRh
YmxlLCBsaWtlbHkgc3Rkb3V0L2Vyci48YnI+DQorICovPGJyPg0KK3N0YXRpYyBpbnQ8YnI+DQor
c2V0dXBfbWFzdGVyX3B0eShpbnQqIHB0eV9tYXN0ZXIsIGludCogcHR5X3NsYXZlLCBjaGFyKnB0
eV9uYW1lLCBGSUxFICpmcCkgezxicj4NCivCoCDCoCDCoCDCoGlmIChvcGVucHR5KHB0eV9tYXN0
ZXIsIHB0eV9zbGF2ZSwgcHR5X25hbWUsIE5VTEwsIE5VTEwpICZsdDsgMCkgezxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICZxdW90O0VSUk9SOiBvcGVucHR5KCkgZmFp
bGVkIHdpdGg6ICVzLlxuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykpOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiAtMTs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKg
IMKgcmV0dXJuIDA7PGJyPg0KK308YnI+DQorPGJyPg0KwqAvKiBSZXR1cm5zIGFuIGludGVnZXIg
ZmlsZSBkZXNjcmlwdG9yLjxicj4NCsKgICogSWYgaXQgcmV0dXJucyAmbHQ7IDAsIGFuIGVycm9y
IGhhcyBvY2N1cnJlZC48YnI+DQrCoCAqIE90aGVyd2lzZSwgaXQgaGFzIHJldHVybmVkIHRoZSBz
bGF2ZSBwdHkgZmlsZSBkZXNjcmlwdG9yLjxicj4NCsKgICogZnAgc2hvdWxkIGJlIHdyaXRhYmxl
LCBsaWtlbHkgc3Rkb3V0L2Vyci48YnI+DQrCoCAqLzxicj4NCsKgc3RhdGljIGludDxicj4NCi1z
ZXR1cF9zbGF2ZV9wdHkoRklMRSAqZnApIHs8YnI+DQotwqAgwqAgwqAgwqBpbnQgcHR5X21hc3Rl
ciA9IC0xOzxicj4NCi3CoCDCoCDCoCDCoGludCBwdHlfc2xhdmUgPSAtMTs8YnI+DQotwqAgwqAg
wqAgwqBjaGFyIHB0eV9uYW1lWzI1Nl07PGJyPg0KK3NldHVwX3NsYXZlX3B0eShjaGFyKiBwdHlf
bmFtZSwgRklMRSAqZnApIHs8YnI+DQrCoCDCoCDCoCDCoCBzdHJ1Y3QgZ3JvdXAgKmdwdHI7PGJy
Pg0KwqAgwqAgwqAgwqAgZ2lkX3QgZ2lkOzxicj4NCsKgIMKgIMKgIMKgIGludCBzbGF2ZSA9IC0x
Ozxicj4NCjxicj4NCi3CoCDCoCDCoCDCoGlmIChvcGVucHR5KCZhbXA7cHR5X21hc3RlciwgJmFt
cDtwdHlfc2xhdmUsIHB0eV9uYW1lLCBOVUxMLCBOVUxMKSAmbHQ7IDApIHs8YnI+DQotwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogb3BlbnB0eSgpIGZhaWxl
ZCB3aXRoOiAlcy5cbiZxdW90Oywgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gLTE7PGJyPg0KLcKgIMKgIMKgIMKgfTxicj4NCi08YnI+DQrCoCDC
oCDCoCDCoCBpZiAoKGdwdHIgPSBnZXRncm5hbShwdHlfbmFtZSkpICE9IDApIHs8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBnaWQgPSBncHRyLSZndDtncl9naWQ7PGJyPg0KwqAgwqAgwqAg
wqAgfSBlbHNlIHs8YnI+DQpAQCAtMzg0LDkgKzM5MCw5IEBAIHNldHVwX3NsYXZlX3B0eShGSUxF
ICpmcCkgezxicj4NCsKgIMKgIMKgIMKgIGlmICgoc2xhdmUgPSBvcGVuKHB0eV9uYW1lLCBPX1JE
V1IpKSA9PSAtMSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoZnAsICZx
dW90O0VSUk9SOiBvcGVuKCkgZmFpbGVkIHdpdGg6ICVzLlxuJnF1b3Q7LCBzdHJlcnJvcihlcnJu
bykpOzxicj4NCsKgIMKgIMKgIMKgIH08YnI+DQotwqAgwqAgwqAgwqByZXR1cm4gKHNsYXZlKTs8
YnI+DQotfTxicj4NCjxicj4NCivCoCDCoCDCoCDCoHJldHVybiBzbGF2ZTs8YnI+DQorfTxicj4N
Cjxicj4NCsKgaW50PGJyPg0KwqBydW5fcHRlc3RzKHN0cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBj
b25zdCBzdHJ1Y3QgcHRlc3Rfb3B0aW9ucyBvcHRzLDxicj4NCkBAIC00MDYsMTYgKzQxMiwxMyBA
QCBydW5fcHRlc3RzKHN0cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdCBzdHJ1Y3QgcHRlc3Rf
b3B0aW9ucyBvcHRzLDxicj4NCjxicj4NCsKgIMKgIMKgIMKgIGRvPGJyPg0KwqAgwqAgwqAgwqAg
ezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChpc2F0dHkoMCkgJmFtcDsmYW1wOyBp
b2N0bCgwLCBUSU9DTk9UVFkpID09IC0xKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IFVuYWJsZSB0byBkZXRhY2ggZnJv
bSBjb250cm9sbGluZyB0dHksICVzXG4mcXVvdDssIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi08YnI+DQotPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZnByaW50ZihmcCwgJnF1b3Q7U1RBUlQ6ICVzXG4mcXVvdDssIHByb2duYW1lKTs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQVEVTVF9MSVNUX0lURVJBVEVfU1RBUlQoaGVh
ZCwgcCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQgcGlwZWZk
X3N0ZG91dFsyXSA9IHstMSwgLTF9Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGludCBwaXBlZmRfc3RkZXJyWzJdID0gey0xLCAtMX07PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50IHBnaWQgPSAtMTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgcHR5X21hc3RlciA9IC0xOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludCBwdHlfc2xhdmUgPSAtMTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjaGFyIHB0eV9uYW1lWzI1Nl0gPSB7MH07
PGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHBpcGUy
KHBpcGVmZF9zdGRvdXQsIDApID09IC0xKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmMgPSAtMTs8YnI+DQpAQCAtNDM1LDggKzQzOCw5IEBA
IHJ1bl9wdGVzdHMoc3RydWN0IHB0ZXN0X2xpc3QgKmhlYWQsIGNvbnN0IHN0cnVjdCBwdGVzdF9v
cHRpb25zIG9wdHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpcm5hbWUocHRlc3RfZGly
KTs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoKHBn
aWQgPSBnZXRwZ2lkKDApKSA9PSAtMSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICZxdW90O0VSUk9SOiBnZXRwZ2lkKCkg
ZmFpbGVkLCAlc1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykpOzxicj48L2Jsb2NrcXVvdGU+PGRp
dj48YnI+PC9kaXY+PGRpdj5UaGlzIGNvbWVzIGZyb20gUmFuZHkgcGF0Y2ggdG8gZW5zdXJlIGNo
aWxkIHRlc3RzIGFyZSBpbiB0aGUgc2FtZSBwcm9jZXNzIGdyb3VwIHRoYW4gdGhlIHB0ZXN0LXJ1
bm5lcizCoDU5MzgxYTY0LiBBbnkgc3BlY2lmaWMgcmVhc29uIHRvIHJlbW92ZSB0aGlzPy48L2Rp
dj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFy
Z2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwy
MDQpO3BhZGRpbmctbGVmdDoxZXgiPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKHNldHVwX21hc3Rlcl9wdHkoJmFtcDtwdHlfbWFzdGVyLCAmYW1wO3B0eV9zbGF2ZSwg
cHR5X25hbWUsIGZwKSAmbHQ7IDApIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogc2V0dXBfbWFzdGVy
X3B0eSBmYWlsZWQsICVzXG4mcXVvdDssIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBpZF90IGNoaWxkID0gZm9yaygpOzxicj4NCkBAIC00NDcs
MjUgKzQ1MSwzMiBAQCBydW5fcHRlc3RzKHN0cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdCBz
dHJ1Y3QgcHRlc3Rfb3B0aW9ucyBvcHRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIH0gZWxzZSBpZiAoY2hpbGQgPT0gMCkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCBzbGF2ZTs8YnI+DQo8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9zZSgwKTs8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBDbG9z
ZSByZWFkIGVuZHMgb2YgdGhlIHBpcGUgKi88YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkb19jbG9zZSgmYW1wO3BpcGVmZF9zdGRvdXRbUElQRV9S
RUFEXSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZG9fY2xvc2UoJmFtcDtwaXBlZmRfc3RkZXJyW1BJUEVfUkVBRF0pOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRvX2Nsb3NlKCZhbXA7cHR5
X21hc3Rlcik7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWYgKChzbGF2ZSA9IHNldHVwX3NsYXZlX3B0eShmcCkpICZsdDsgMCkgezxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICgo
c2xhdmUgPSBzZXR1cF9zbGF2ZV9wdHkocHR5X25hbWUsIGZwKSkgJmx0OyAwKSB7PGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
ZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IGNvdWxkIG5vdCBzZXR1cCBwdHkgKCVkKS4mcXVvdDss
IHNsYXZlKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB9PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgKHNldHBnaWQoMCxwZ2lkKSA9PSAtMSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICZxdW90
O0VSUk9SOiBzZXRwZ2lkKCkgZmFpbGVkLCAlc1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykpOzxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+
DQo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBp
ZiAoc2V0c2lkKCkgPT3CoCAtMSkgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZwcmludGYoZnAsICZxdW90O0VSUk9SOiBz
ZXRzaWQoKSBmYWlsZWQsICVzXG4mcXVvdDssIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChpb2N0bCgw
LCBUSU9DU0NUVFksIE5VTEwpID09IC0xKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGlvY3RsKHNsYXZlLCBUSU9DU0NUVFksIE5VTEwp
ID09IC0xKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IFVuYWJsZSB0byBhdHRh
Y2ggdG8gY29udHJvbGxpbmcgdHR5LCAlc1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykpOzxicj4N
CsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH3CoDwvYmxv
Y2txdW90ZT48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4
IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFk
ZGluZy1sZWZ0OjFleCI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAoc2xhdmUgJmd0OyAyKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2xvc2Uoc2xhdmUpOzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGR1
cDIocHR5X3NsYXZlLCBTVERJTl9GSUxFTk8pICZsdDsgMCkgezxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAs
ICZxdW90O0VSUk9SOiBVbmFibGUgdG8gZHVwIHNsYXZlIHB0eSB0byBzdGRpbiwgJXNcbiZxdW90
Oywgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKHB0eV9zbGF2ZSAmZ3Q7IDIpIHs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9zZShwdHlf
c2xhdmUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoH08YnI+PC9ibG9ja3F1b3RlPjxkaXY+V2hpY2ggaXMgdGhlIHJlYXNvbiB0byBtYWtlIGl0
IHR3aWNlPywgYW5kIGFsc28gY2xvc2luZyB3aXRoIHNsYXZlICZndDsgMi48YnI+PC9kaXY+PGRp
dj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtw
YWRkaW5nLWxlZnQ6MWV4Ij4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGlmIChjaGRpcihwdGVzdF9kaXIpID09IC0xKSB7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnBy
aW50ZihmcCwgJnF1b3Q7RVJST1I6IFVuYWJsZSB0byBjaGRpciglcyksICVzXG4mcXVvdDssIHB0
ZXN0X2Rpciwgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQpAQCAtNDgxLDEwICs0OTIsNiBAQCBydW5f
cHRlc3RzKHN0cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdCBzdHJ1Y3QgcHRlc3Rfb3B0aW9u
cyBvcHRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGRvX2Nsb3NlKCZhbXA7cGlwZWZkX3N0ZG91dFtQSVBFX1dSSVRFXSk7PGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZG9fY2xvc2UoJmFtcDtw
aXBlZmRfc3RkZXJyW1BJUEVfV1JJVEVdKTs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2V0cGdpZChjaGlsZCwgcGdpZCkgPT0g
LTEpIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogc2V0cGdpZCgpIGZhaWxlZCwg
JXNcbiZxdW90Oywgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KLTxicj48L2Jsb2NrcXVvdGU+PGRpdj5S
ZW1vdmFsIGNvbW1lbnQgdXAuPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJn
bWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDox
cHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHRpbWVfdCBzdGFydF90aW1lPSB0
aW1lKE5VTEwpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGZwcmludGYoZnAsICZxdW90OyVzXG4mcXVvdDssIGdldF9zdGltZShzdGltZSwgR0VU
X1NUSU1FX0JVRl9TSVpFLCBzdGFydF90aW1lKSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwgJnF1b3Q7QkVHSU46ICVzXG4m
cXVvdDssIHB0ZXN0X2Rpcik7PGJyPg0KQEAgLTYwOCw2ICs2MTUsOCBAQCBydW5fcHRlc3RzKHN0
cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdCBzdHJ1Y3QgcHRlc3Rfb3B0aW9ucyBvcHRzLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRvX2Nsb3NlKCZhbXA7cGlw
ZWZkX3N0ZG91dFtQSVBFX1dSSVRFXSk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZG9fY2xvc2UoJmFtcDtwaXBlZmRfc3RkZXJyW1BJUEVfUkVBRF0pOzxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRvX2Nsb3NlKCZhbXA7cGlwZWZkX3N0
ZGVycltQSVBFX1dSSVRFXSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgZG9fY2xvc2UoJmFtcDtwdHlfbWFzdGVyKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBkb19jbG9zZSgmYW1wO3B0eV9zbGF2ZSk7PGJyPg0KPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmZsdXNoKGZwKTs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmZmx1c2goZnBfc3RkZXJyKTs8YnI+DQotLSA8YnI+
DQoyLjI1LjE8YnI+DQo8YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+DQo=
--0000000000000f4fcf0616f2e9f5--

