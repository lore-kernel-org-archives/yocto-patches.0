Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01346C10F16
	for <webhook@archiver.kernel.org>; Mon,  6 May 2024 15:45:16 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
 by mx.groups.io with SMTP id smtpd.web10.24235.1715010311038184128
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 May 2024 08:45:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=DxwZiN0Z;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.179, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61e0c2b5cd2so29943887b3.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 May 2024 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1715010310; x=1715615110; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+NEOjzo8U0SHh3EgMxvNhRR26S6SFGG6+EZJmyH+in0=;
        b=DxwZiN0Z2tSvaDnk7IwPhF92oZl6THTcphPnvVXnRNLEvjJ5rOdsi2l1jYA9IHyKVf
         ZHNdbISIOTOOSPK7CNGHQvtgjSqJQk3dehwvmpNEfbbiQEMtMQkPooMrTwzE1DaDkXsg
         yHZhe7zduFjMvPD/YBXQCFIEKGgZwqjqzSiyRip/nVwL025DEmv0co/WfykJUb00tf9Y
         8JGCMcOKVKMZemWBVgvj+129XoBSotJIs1ruT8vtjAuCxbDck8HPJtu6CgGa9KOV35yk
         Z958DAT+gBygVMPsmMq7aLqwmZh8YUuNlUU00wuoQA/I398pOFgoAYD5TS865ZTc4DGn
         8pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010310; x=1715615110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NEOjzo8U0SHh3EgMxvNhRR26S6SFGG6+EZJmyH+in0=;
        b=C+ZZfsMhztFmOKVHQ5fA/zHCYz9b+MtoaplgRjijcECr6kLWmR6ZIE1C/fFpZ8IhTk
         FbqLvn4/w84J2RoLdqs/zP3Uwt5ps4cbvCYKDwpfQ4wz3S6EXVw3/WZW5C2nP/e6eDUu
         79FBOPj2jGIeNCOVB1at9GWrEUC8VW5cqJp4PbgjRcbagTk7BrUzhkWf2tEmQthLIax0
         tVqUeDmhv0nEmQj/LsZiVM6Kd0ahdEa2ciGExtkc/iRex9/UJ8+Fqv9X+jP/weEO7oQM
         tGccU26ao0Y/+IPYiyHBqAGs+8ISGIve6gXVNx8y554cMPKmbtovwrHDNh7iaDTZZfS+
         wJYg==
X-Forwarded-Encrypted: i=1; AJvYcCXHKcacnjYUxhuAFk5Wpu1Gn0CitDKrbKTgVhtM7FMyJp4YsME3jybjBOjk1Bvo8M9XOsoR7vSo/5HZY8gy2aasNydRW2wdZBmR9+GoiTnksQC/iwk=
X-Gm-Message-State: AOJu0YzER59uFzZvhuGVwxc0qkZBZ8scjr+6LWDuhepr3Scoqbu1d1cc
	EAiKaX61QisN4x3zb2Jzh39/IjKKcM3FM0jROrYSx9AfkwSKSbVORtPaPJQ1yeNYECFYpb5ATE0
	WlYMI+NIJyffWQSwSUoUI1rkXBHLQX0OZYdK7RP8nAlhMYUbiJBs=
X-Google-Smtp-Source: AGHT+IF51R0ZQVwxSAIqWrDdesnmKlmk1T1mLqe+4BVmVaOuAatfdW3Ze0WRGO50kghsALeqXEPk7QYQvGAG8LzrARE=
X-Received: by 2002:a0d:d9d5:0:b0:61b:e13c:e3f4 with SMTP id
 00721157ae682-62076592bf9mr313937b3.15.1715010309991; Mon, 06 May 2024
 08:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <17CCF08ED1ED8647.29739@lists.yoctoproject.org>
In-Reply-To: <17CCF08ED1ED8647.29739@lists.yoctoproject.org>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Mon, 6 May 2024 09:44:59 -0600
Message-ID: <CAOU5ZMuzwmC_BAZGGgG+5+Ejy6O5XvqUuz+07zZMNhwQ0X541g@mail.gmail.com>
Subject: Re: [yocto-patches] [ptest-runner 1/2] utils.c: run-ptests improve
 pseudo-terminal handling
To: changqing.li@windriver.com
Cc: randy.macleod@windriver.com, yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000504e900617caf497"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 May 2024 15:45:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/86

--000000000000504e900617caf497
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Changqing,

I spent some time reviewing the patch and this is a reduced version of it,

If the parent set up a pty and then set up the child as stdin, It all needs
to cover your case and previous cases raised by Randy.

I tested the libtevent ptest and passed the 3 tests with this patch.

Regards!,
Anibal

On Mon, May 6, 2024 at 9:40=E2=80=AFAM Anibal Limon via lists.yoctoproject.=
org
<anibal=3Dlimonsoftware.com@lists.yoctoproject.org> wrote:

> Setup master and slave pty before run ptest, on child attach to the
> slave pty and set it as controlling tty and stdin.
>
> See rev 59381a643e1fcce9b6920cb59af9402dd5eb0dfb .
>
> Co-authored-by: Changqing Li <changqing.li@windriver.com>
> Signed-off-by: Anibal Limon <anibal@limonsoftware.com>
> ---
>  utils.c | 90 ++++++++++++---------------------------------------------
>  1 file changed, 19 insertions(+), 71 deletions(-)
>
> diff --git a/utils.c b/utils.c
> index 46918f4..3a35313 100644
> --- a/utils.c
> +++ b/utils.c
> @@ -341,53 +341,6 @@ run_child(char *run_ptest, int fd_stdout, int
> fd_stderr)
>         /* exit(1); not needed? */
>  }
>
> -/* Returns an integer file descriptor.
> - * If it returns < 0, an error has occurred.
> - * Otherwise, it has returned the slave pty file descriptor.
> - * fp should be writable, likely stdout/err.
> - */
> -static int
> -setup_slave_pty(FILE *fp) {
> -       int pty_master =3D -1;
> -       int pty_slave =3D -1;
> -       char pty_name[256];
> -       struct group *gptr;
> -       gid_t gid;
> -       int slave =3D -1;
> -
> -       if (openpty(&pty_master, &pty_slave, pty_name, NULL, NULL) < 0) {
> -               fprintf(fp, "ERROR: openpty() failed with: %s.\n",
> strerror(errno));
> -               return -1;
> -       }
> -
> -       if ((gptr =3D getgrnam(pty_name)) !=3D 0) {
> -               gid =3D gptr->gr_gid;
> -       } else {
> -               /* If the tty group does not exist, don't change the
> -                * group on the slave pty, only the owner
> -                */
> -               gid =3D (gid_t)-1;
> -       }
> -
> -       /* chown/chmod the corresponding pty, if possible.
> -        * This will only work if the process has root permissions.
> -        */
> -       if (chown(pty_name, getuid(), gid) !=3D 0) {
> -               fprintf(fp, "ERROR; chown() failed with: %s.\n",
> strerror(errno));
> -       }
> -
> -       /* Makes the slave read/writeable for the user. */
> -       if (chmod(pty_name, S_IRUSR|S_IWUSR) !=3D 0) {
> -               fprintf(fp, "ERROR: chmod() failed with: %s.\n",
> strerror(errno));
> -       }
> -
> -       if ((slave =3D open(pty_name, O_RDWR)) =3D=3D -1) {
> -               fprintf(fp, "ERROR: open() failed with: %s.\n",
> strerror(errno));
> -       }
> -       return (slave);
> -}
> -
> -
>  int
>  run_ptests(struct ptest_list *head, const struct ptest_options opts,
>                 const char *progname, FILE *fp, FILE *fp_stderr)
> @@ -406,16 +359,12 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>
>         do
>         {
> -               if (isatty(0) && ioctl(0, TIOCNOTTY) =3D=3D -1) {
> -                       fprintf(fp, "ERROR: Unable to detach from
> controlling tty, %s\n", strerror(errno));
> -               }
> -
>
>                 fprintf(fp, "START: %s\n", progname);
>                 PTEST_LIST_ITERATE_START(head, p)
>                         int pipefd_stdout[2] =3D {-1, -1};
>                         int pipefd_stderr[2] =3D {-1, -1};
> -                       int pgid =3D -1;
> +                       int pty[2] =3D {-1, -1};
>
>                         if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
>                                 rc =3D -1;
> @@ -428,6 +377,16 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>                                 break;
>                         }
>
> +                       if (openpty(&pty[0], &pty[1], NULL, NULL, NULL) <
> 0) {
> +                               fprintf(fp, "ERROR: openpty() failed with=
:
> %s.\n", strerror(errno));
> +                               close(pipefd_stderr[PIPE_READ]);
> +                               close(pipefd_stderr[PIPE_WRITE]);
> +                               close(pipefd_stdout[PIPE_READ]);
> +                               close(pipefd_stdout[PIPE_WRITE]);
> +                               rc =3D -1;
> +                               break;
> +                       }
> +
>                         char *ptest_dir =3D strdup(p->run_ptest);
>                         if (ptest_dir =3D=3D NULL) {
>                                 rc =3D -1;
> @@ -435,38 +394,31 @@ run_ptests(struct ptest_list *head, const struct
> ptest_options opts,
>                         }
>                         dirname(ptest_dir);
>
> -                       if ((pgid =3D getpgid(0)) =3D=3D -1) {
> -                               fprintf(fp, "ERROR: getpgid() failed,
> %s\n", strerror(errno));
> -                       }
> -
>                         pid_t child =3D fork();
>                         if (child =3D=3D -1) {
>                                 fprintf(fp, "ERROR: Fork %s\n",
> strerror(errno));
>                                 rc =3D -1;
>                                 break;
>                         } else if (child =3D=3D 0) {
> -                               int slave;
> -
> -                               close(0);
>                                 /* Close read ends of the pipe */
>                                 do_close(&pipefd_stdout[PIPE_READ]);
>                                 do_close(&pipefd_stderr[PIPE_READ]);
>
> -                               if ((slave =3D setup_slave_pty(fp)) < 0) =
{
> -                                       fprintf(fp, "ERROR: could not
> setup pty (%d).", slave);
> -                               }
> -                               if (setpgid(0,pgid) =3D=3D -1) {
> -                                       fprintf(fp, "ERROR: setpgid()
> failed, %s\n", strerror(errno));
> -                               }
> +                               /* Close master pty and set slave pty as
> stdin */
> +                               do_close(&pty[0]);
>
>                                 if (setsid() =3D=3D  -1) {
>                                         fprintf(fp, "ERROR: setsid()
> failed, %s\n", strerror(errno));
>                                 }
> -
> -                               if (ioctl(0, TIOCSCTTY, NULL) =3D=3D -1) =
{
> +                               if (ioctl(pty[1], TIOCSCTTY, NULL) =3D=3D=
 -1) {
>                                         fprintf(fp, "ERROR: Unable to
> attach to controlling tty, %s\n", strerror(errno));
>                                 }
>
> +                               if (dup2(pty[1], STDIN_FILENO) < 0) {
> +                                       fprintf(fp, "ERROR: Unable to dup
> slave pty to stdin, %s\n", strerror(errno));
> +                               }
> +                               do_close(&pty[1]);
> +
>                                 if (chdir(ptest_dir) =3D=3D -1) {
>                                         fprintf(fp, "ERROR: Unable to
> chdir(%s), %s\n", ptest_dir, strerror(errno));
>                                 } else {
> @@ -481,10 +433,6 @@ run_ptests(struct ptest_list *head, const struct
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
> --
> 2.43.0
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#84):
> https://lists.yoctoproject.org/g/yocto-patches/message/84
> Mute This Topic: https://lists.yoctoproject.org/mt/105941917/8181911
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe:
> https://lists.yoctoproject.org/g/yocto-patches/leave/13235916/8181911/179=
31940/xyzzy
> [anibal@limonsoftware.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>

--000000000000504e900617caf497
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGkgQ2hhbmdxaW5nLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSBzcGVudCBz
b21lIHRpbWUgcmV2aWV3aW5nIHRoZSBwYXRjaCBhbmQgdGhpcyBpcyBhIHJlZHVjZWQgdmVyc2lv
biBvZiBpdCw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PklmIHRoZSBwYXJlbnQgc2V0IHVwIGEg
cHR5IGFuZCB0aGVuIHNldCB1cCB0aGUgY2hpbGQgYXMgc3RkaW4sIEl0IGFsbCBuZWVkcyB0byBj
b3ZlciB5b3VyIGNhc2UgYW5kIHByZXZpb3VzIGNhc2VzIHJhaXNlZCBieSBSYW5keS48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PkkgdGVzdGVkIHRoZSBsaWJ0ZXZlbnQgcHRlc3QgYW5kIHBhc3Nl
ZCB0aGUgMyB0ZXN0cyB3aXRoIHRoaXMgcGF0Y2guPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5S
ZWdhcmRzISw8L2Rpdj48ZGl2PkFuaWJhbDwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFp
bF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgTWF5IDYs
IDIwMjQgYXQgOTo0MOKAr0FNIEFuaWJhbCBMaW1vbiB2aWEgPGEgaHJlZj0iaHR0cDovL2xpc3Rz
LnlvY3RvcHJvamVjdC5vcmciPmxpc3RzLnlvY3RvcHJvamVjdC5vcmc8L2E+ICZsdDthbmliYWw9
PGEgaHJlZj0ibWFpbHRvOmxpbW9uc29mdHdhcmUuY29tQGxpc3RzLnlvY3RvcHJvamVjdC5vcmci
PmxpbW9uc29mdHdhcmUuY29tQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc8L2E+Jmd0OyB3cm90ZTo8
YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBw
eCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3Bh
ZGRpbmctbGVmdDoxZXgiPlNldHVwIG1hc3RlciBhbmQgc2xhdmUgcHR5IGJlZm9yZSBydW4gcHRl
c3QsIG9uIGNoaWxkIGF0dGFjaCB0byB0aGU8YnI+DQpzbGF2ZSBwdHkgYW5kIHNldCBpdCBhcyBj
b250cm9sbGluZyB0dHkgYW5kIHN0ZGluLjxicj4NCjxicj4NClNlZSByZXYgNTkzODFhNjQzZTFm
Y2NlOWI2OTIwY2I1OWFmOTQwMmRkNWViMGRmYiAuPGJyPg0KPGJyPg0KQ28tYXV0aG9yZWQtYnk6
IENoYW5ncWluZyBMaSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNoYW5ncWluZy5saUB3aW5kcml2ZXIu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+Y2hhbmdxaW5nLmxpQHdpbmRyaXZlci5jb208L2E+Jmd0Ozxi
cj4NClNpZ25lZC1vZmYtYnk6IEFuaWJhbCBMaW1vbiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuaWJh
bEBsaW1vbnNvZnR3YXJlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFuaWJhbEBsaW1vbnNvZnR3YXJl
LmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0KwqB1dGlscy5jIHwgOTAgKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPg0KwqAxIGZpbGUg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNzEgZGVsZXRpb25zKC0pPGJyPg0KPGJyPg0KZGlm
ZiAtLWdpdCBhL3V0aWxzLmMgYi91dGlscy5jPGJyPg0KaW5kZXggNDY5MThmNC4uM2EzNTMxMyAx
MDA2NDQ8YnI+DQotLS0gYS91dGlscy5jPGJyPg0KKysrIGIvdXRpbHMuYzxicj4NCkBAIC0zNDEs
NTMgKzM0MSw2IEBAIHJ1bl9jaGlsZChjaGFyICpydW5fcHRlc3QsIGludCBmZF9zdGRvdXQsIGlu
dCBmZF9zdGRlcnIpPGJyPg0KwqAgwqAgwqAgwqAgLyogZXhpdCgxKTsgbm90IG5lZWRlZD8gKi88
YnI+DQrCoH08YnI+DQo8YnI+DQotLyogUmV0dXJucyBhbiBpbnRlZ2VyIGZpbGUgZGVzY3JpcHRv
ci48YnI+DQotICogSWYgaXQgcmV0dXJucyAmbHQ7IDAsIGFuIGVycm9yIGhhcyBvY2N1cnJlZC48
YnI+DQotICogT3RoZXJ3aXNlLCBpdCBoYXMgcmV0dXJuZWQgdGhlIHNsYXZlIHB0eSBmaWxlIGRl
c2NyaXB0b3IuPGJyPg0KLSAqIGZwIHNob3VsZCBiZSB3cml0YWJsZSwgbGlrZWx5IHN0ZG91dC9l
cnIuPGJyPg0KLSAqLzxicj4NCi1zdGF0aWMgaW50PGJyPg0KLXNldHVwX3NsYXZlX3B0eShGSUxF
ICpmcCkgezxicj4NCi3CoCDCoCDCoCDCoGludCBwdHlfbWFzdGVyID0gLTE7PGJyPg0KLcKgIMKg
IMKgIMKgaW50IHB0eV9zbGF2ZSA9IC0xOzxicj4NCi3CoCDCoCDCoCDCoGNoYXIgcHR5X25hbWVb
MjU2XTs8YnI+DQotwqAgwqAgwqAgwqBzdHJ1Y3QgZ3JvdXAgKmdwdHI7PGJyPg0KLcKgIMKgIMKg
IMKgZ2lkX3QgZ2lkOzxicj4NCi3CoCDCoCDCoCDCoGludCBzbGF2ZSA9IC0xOzxicj4NCi08YnI+
DQotwqAgwqAgwqAgwqBpZiAob3BlbnB0eSgmYW1wO3B0eV9tYXN0ZXIsICZhbXA7cHR5X3NsYXZl
LCBwdHlfbmFtZSwgTlVMTCwgTlVMTCkgJmx0OyAwKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IG9wZW5wdHkoKSBmYWlsZWQgd2l0aDogJXMu
XG4mcXVvdDssIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0dXJuIC0xOzxicj4NCi3CoCDCoCDCoCDCoH08YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgaWYg
KChncHRyID0gZ2V0Z3JuYW0ocHR5X25hbWUpKSAhPSAwKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgZ2lkID0gZ3B0ci0mZ3Q7Z3JfZ2lkOzxicj4NCi3CoCDCoCDCoCDCoH0gZWxzZSB7
PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogSWYgdGhlIHR0eSBncm91cCBkb2VzIG5v
dCBleGlzdCwgZG9uJiMzOTt0IGNoYW5nZSB0aGU8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKiBncm91cCBvbiB0aGUgc2xhdmUgcHR5LCBvbmx5IHRoZSBvd25lcjxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAqLzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGdpZCA9IChn
aWRfdCktMTs8YnI+DQotwqAgwqAgwqAgwqB9PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoC8qIGNo
b3duL2NobW9kIHRoZSBjb3JyZXNwb25kaW5nIHB0eSwgaWYgcG9zc2libGUuPGJyPg0KLcKgIMKg
IMKgIMKgICogVGhpcyB3aWxsIG9ubHkgd29yayBpZiB0aGUgcHJvY2VzcyBoYXMgcm9vdCBwZXJt
aXNzaW9ucy48YnI+DQotwqAgwqAgwqAgwqAgKi88YnI+DQotwqAgwqAgwqAgwqBpZiAoY2hvd24o
cHR5X25hbWUsIGdldHVpZCgpLCBnaWQpICE9IDApIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjsgY2hvd24oKSBmYWlsZWQgd2l0aDogJXMuXG4m
cXVvdDssIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KLcKgIMKgIMKgIMKgfTxicj4NCi08YnI+DQot
wqAgwqAgwqAgwqAvKiBNYWtlcyB0aGUgc2xhdmUgcmVhZC93cml0ZWFibGUgZm9yIHRoZSB1c2Vy
LiAqLzxicj4NCi3CoCDCoCDCoCDCoGlmIChjaG1vZChwdHlfbmFtZSwgU19JUlVTUnxTX0lXVVNS
KSAhPSAwKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihmcCwgJnF1b3Q7
RVJST1I6IGNobW9kKCkgZmFpbGVkIHdpdGg6ICVzLlxuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykp
Ozxicj4NCi3CoCDCoCDCoCDCoH08YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgaWYgKChzbGF2ZSA9
IG9wZW4ocHR5X25hbWUsIE9fUkRXUikpID09IC0xKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IG9wZW4oKSBmYWlsZWQgd2l0aDogJXMuXG4m
cXVvdDssIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KLcKgIMKgIMKgIMKgfTxicj4NCi3CoCDCoCDC
oCDCoHJldHVybiAoc2xhdmUpOzxicj4NCi19PGJyPg0KLTxicj4NCi08YnI+DQrCoGludDxicj4N
CsKgcnVuX3B0ZXN0cyhzdHJ1Y3QgcHRlc3RfbGlzdCAqaGVhZCwgY29uc3Qgc3RydWN0IHB0ZXN0
X29wdGlvbnMgb3B0cyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25zdCBjaGFyICpw
cm9nbmFtZSwgRklMRSAqZnAsIEZJTEUgKmZwX3N0ZGVycik8YnI+DQpAQCAtNDA2LDE2ICszNTks
MTIgQEAgcnVuX3B0ZXN0cyhzdHJ1Y3QgcHRlc3RfbGlzdCAqaGVhZCwgY29uc3Qgc3RydWN0IHB0
ZXN0X29wdGlvbnMgb3B0cyw8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBkbzxicj4NCsKgIMKgIMKg
IMKgIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoaXNhdHR5KDApICZhbXA7JmFt
cDsgaW9jdGwoMCwgVElPQ05PVFRZKSA9PSAtMSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICZxdW90O0VSUk9SOiBVbmFibGUgdG8gZGV0YWNo
IGZyb20gY29udHJvbGxpbmcgdHR5LCAlc1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykpOzxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQotPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZnByaW50ZihmcCwgJnF1b3Q7U1RBUlQ6ICVzXG4mcXVvdDssIHByb2duYW1l
KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBQVEVTVF9MSVNUX0lURVJBVEVfU1RBUlQo
aGVhZCwgcCk8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQgcGlw
ZWZkX3N0ZG91dFsyXSA9IHstMSwgLTF9Ozxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGludCBwaXBlZmRfc3RkZXJyWzJdID0gey0xLCAtMX07PGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50IHBnaWQgPSAtMTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbnQgcHR5WzJdID0gey0xLCAtMX07PGJyPg0KPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHBpcGUyKHBpcGVmZF9z
dGRvdXQsIDApID09IC0xKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcmMgPSAtMTs8YnI+DQpAQCAtNDI4LDYgKzM3NywxNiBAQCBydW5fcHRl
c3RzKHN0cnVjdCBwdGVzdF9saXN0ICpoZWFkLCBjb25zdCBzdHJ1Y3QgcHRlc3Rfb3B0aW9ucyBv
cHRzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGJyZWFrOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAob3BlbnB0eSgmYW1w
O3B0eVswXSwgJmFtcDtwdHlbMV0sIE5VTEwsIE5VTEwsIE5VTEwpICZsdDsgMCkgezxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAs
ICZxdW90O0VSUk9SOiBvcGVucHR5KCkgZmFpbGVkIHdpdGg6ICVzLlxuJnF1b3Q7LCBzdHJlcnJv
cihlcnJubykpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGNsb3NlKHBpcGVmZF9zdGRlcnJbUElQRV9SRUFEXSk7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2xvc2UocGlwZWZkX3N0ZGVycltQ
SVBFX1dSSVRFXSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgY2xvc2UocGlwZWZkX3N0ZG91dFtQSVBFX1JFQURdKTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9zZShwaXBlZmRfc3Rkb3V0
W1BJUEVfV1JJVEVdKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByYyA9IC0xOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoH08YnI+DQorPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Y2hhciAqcHRlc3RfZGlyID0gc3RyZHVwKHAtJmd0O3J1bl9wdGVzdCk7PGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHB0ZXN0X2RpciA9PSBOVUxMKSB7PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmMgPSAtMTs8
YnI+DQpAQCAtNDM1LDM4ICszOTQsMzEgQEAgcnVuX3B0ZXN0cyhzdHJ1Y3QgcHRlc3RfbGlzdCAq
aGVhZCwgY29uc3Qgc3RydWN0IHB0ZXN0X29wdGlvbnMgb3B0cyw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZGlybmFtZShwdGVzdF9kaXIpOzxicj4NCjxicj4NCi3CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlmICgocGdpZCA9IGdldHBnaWQoMCkpID09IC0xKSB7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50Zihm
cCwgJnF1b3Q7RVJST1I6IGdldHBnaWQoKSBmYWlsZWQsICVzXG4mcXVvdDssIHN0cmVycm9yKGVy
cm5vKSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCi08
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwaWRfdCBjaGlsZCA9IGZv
cmsoKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoY2hpbGQg
PT0gLTEpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogRm9yayAlc1xuJnF1b3Q7LCBzdHJlcnJvcihl
cnJubykpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHJjID0gLTE7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgYnJlYWs7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fSBlbHNlIGlmIChjaGlsZCA9PSAwKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaW50IHNsYXZlOzxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjbG9zZSgwKTs8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBDbG9zZSByZWFkIGVu
ZHMgb2YgdGhlIHBpcGUgKi88YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBkb19jbG9zZSgmYW1wO3BpcGVmZF9zdGRvdXRbUElQRV9SRUFEXSk7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZG9fY2xv
c2UoJmFtcDtwaXBlZmRfc3RkZXJyW1BJUEVfUkVBRF0pOzxicj4NCjxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICgoc2xhdmUgPSBzZXR1cF9z
bGF2ZV9wdHkoZnApKSAmbHQ7IDApIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjog
Y291bGQgbm90IHNldHVwIHB0eSAoJWQpLiZxdW90Oywgc2xhdmUpOzxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQotwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoc2V0cGdpZCgwLHBnaWQpID09
IC0xKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IHNldHBnaWQoKSBmYWlsZWQs
ICVzXG4mcXVvdDssIHN0cmVycm9yKGVycm5vKSk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIENsb3NlIG1hc3RlciBwdHkgYW5kIHNldCBzbGF2
ZSBwdHkgYXMgc3RkaW4gKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBkb19jbG9zZSgmYW1wO3B0eVswXSk7PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHNldHNpZCgpID09wqAg
LTEpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBmcHJpbnRmKGZwLCAmcXVvdDtFUlJPUjogc2V0c2lkKCkgZmFpbGVkLCAl
c1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGlvY3RsKDAsIFRJT0NTQ1RUWSwgTlVM
TCkgPT0gLTEpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZiAoaW9jdGwocHR5WzFdLCBUSU9DU0NUVFksIE5VTEwpID09IC0xKSB7PGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IFVuYWJsZSB0byBhdHRhY2ggdG8gY29udHJvbGxp
bmcgdHR5LCAlc1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykpOzxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH08YnI+DQo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZHVwMihwdHlbMV0sIFNU
RElOX0ZJTEVOTykgJmx0OyAwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IFVu
YWJsZSB0byBkdXAgc2xhdmUgcHR5IHRvIHN0ZGluLCAlc1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJu
bykpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBk
b19jbG9zZSgmYW1wO3B0eVsxXSk7PGJyPg0KKzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChjaGRpcihwdGVzdF9kaXIpID09IC0xKSB7PGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZnByaW50ZihmcCwgJnF1b3Q7RVJST1I6IFVuYWJsZSB0byBjaGRpciglcyksICVzXG4m
cXVvdDssIHB0ZXN0X2Rpciwgc3RyZXJyb3IoZXJybm8pKTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2Ugezxicj4NCkBAIC00ODEsMTAg
KzQzMyw2IEBAIHJ1bl9wdGVzdHMoc3RydWN0IHB0ZXN0X2xpc3QgKmhlYWQsIGNvbnN0IHN0cnVj
dCBwdGVzdF9vcHRpb25zIG9wdHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZG9fY2xvc2UoJmFtcDtwaXBlZmRfc3Rkb3V0W1BJUEVfV1JJVEVd
KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBk
b19jbG9zZSgmYW1wO3BpcGVmZF9zdGRlcnJbUElQRV9XUklURV0pOzxicj4NCjxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzZXRwZ2lkKGNo
aWxkLCBwZ2lkKSA9PSAtMSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZwcmludGYoZnAsICZxdW90O0VSUk9SOiBzZXRw
Z2lkKCkgZmFpbGVkLCAlc1xuJnF1b3Q7LCBzdHJlcnJvcihlcnJubykpOzxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQotPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdGltZV90IHN0YXJ0
X3RpbWU9IHRpbWUoTlVMTCk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgZnByaW50ZihmcCwgJnF1b3Q7JXNcbiZxdW90OywgZ2V0X3N0aW1lKHN0
aW1lLCBHRVRfU1RJTUVfQlVGX1NJWkUsIHN0YXJ0X3RpbWUpKTs8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJpbnRmKGZwLCAmcXVvdDtCRUdJ
TjogJXNcbiZxdW90OywgcHRlc3RfZGlyKTs8YnI+DQotLSA8YnI+DQoyLjQzLjA8YnI+DQo8YnI+
DQo8YnI+DQo8YnI+DQotPS09LT0tPS09LT0tPS09LT0tPS09LTxicj4NCkxpbmtzOiBZb3UgcmVj
ZWl2ZSBhbGwgbWVzc2FnZXMgc2VudCB0byB0aGlzIGdyb3VwLjxicj4NClZpZXcvUmVwbHkgT25s
aW5lICgjODQpOiA8YSBocmVmPSJodHRwczovL2xpc3RzLnlvY3RvcHJvamVjdC5vcmcvZy95b2N0
by1wYXRjaGVzL21lc3NhZ2UvODQiIHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmh0
dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBhdGNoZXMvbWVzc2FnZS84NDwv
YT48YnI+DQpNdXRlIFRoaXMgVG9waWM6IDxhIGhyZWY9Imh0dHBzOi8vbGlzdHMueW9jdG9wcm9q
ZWN0Lm9yZy9tdC8xMDU5NDE5MTcvODE4MTkxMSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL210LzEwNTk0MTkxNy84MTgxOTEx
PC9hPjxicj4NCkdyb3VwIE93bmVyOiA8YSBocmVmPSJtYWlsdG86eW9jdG8tcGF0Y2hlcyUyQm93
bmVyQGxpc3RzLnlvY3RvcHJvamVjdC5vcmciIHRhcmdldD0iX2JsYW5rIj55b2N0by1wYXRjaGVz
K293bmVyQGxpc3RzLnlvY3RvcHJvamVjdC5vcmc8L2E+PGJyPg0KVW5zdWJzY3JpYmU6IDxhIGhy
ZWY9Imh0dHBzOi8vbGlzdHMueW9jdG9wcm9qZWN0Lm9yZy9nL3lvY3RvLXBhdGNoZXMvbGVhdmUv
MTMyMzU5MTYvODE4MTkxMS8xNzkzMTk0MC94eXp6eSIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9
Il9ibGFuayI+aHR0cHM6Ly9saXN0cy55b2N0b3Byb2plY3Qub3JnL2cveW9jdG8tcGF0Y2hlcy9s
ZWF2ZS8xMzIzNTkxNi84MTgxOTExLzE3OTMxOTQwL3h5enp5PC9hPiBbPGEgaHJlZj0ibWFpbHRv
OmFuaWJhbEBsaW1vbnNvZnR3YXJlLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFuaWJhbEBsaW1vbnNv
ZnR3YXJlLmNvbTwvYT5dPGJyPg0KLT0tPS09LT0tPS09LT0tPS09LT0tPS08YnI+DQo8YnI+DQo8
YnI+DQo8L2Jsb2NrcXVvdGU+PC9kaXY+DQo=
--000000000000504e900617caf497--

