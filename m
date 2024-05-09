Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD822C10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 17:20:48 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web10.1452.1715275239473292681
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 09 May 2024 10:20:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=sUlBYjnc;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.182, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61e0f733e8aso12566737b3.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1715275238; x=1715880038; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g6N36pLwg3ui1gdwYAtD5fcml7kN946e48JiwCYYHdw=;
        b=sUlBYjnczPquRfLP0r1NwDVU+u65U19pPtuF3b84ADxwR81/ZABMKQnJSuz7fsGNkF
         ISY+8dmzdWjYSTrvmvJmhYUrS9Xik1T/OsXAZqyeCzbCMks7E3DotV7WXQ7chBWaUd2d
         yxOmilaL3igTXp6nEf8uV6U0lNTWV6zuFEbISR6Fq23/oYBK/CIlXuaYS68MdfhUgrIL
         A4B7eaKVzfpngvsQ4AkgNoGounXtP9MANTrvx1fRh4bzs/ehuPEjgMqR2qw1V2Jl/bG3
         rwcy0PbXALE0b6T6ijIxHvSRoWfZpDGIMQGBgHu3S8+XdfHTTEhQjtXYVLlE9ZyKB6DX
         AfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715275238; x=1715880038;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6N36pLwg3ui1gdwYAtD5fcml7kN946e48JiwCYYHdw=;
        b=eQejICbL2USRxIvqyhy0beGVVOKk9qtB7x7rGjVe3sDApQb5XFFKx0zTdwqk8JOycS
         SVqxc3W4u0SI3/IYa7RuwZ7K2L8Tx45e0gZf+3kG6H8iJExQZQ4Dp0BVCWd645+EiBZ3
         Xi+KclpzECmHJVpRTjW33K2CF0Q5sVZaMaueqQXQpompkwQ70XloqHvu2QKjOGIbWatS
         02usJsuYln7vf+iYjwyK6M0MAPNwUlNXMJEAAktTQmHmqkyjVNtCGC/2k46OYTQ5sowL
         HhVbusVMHDVZxDOoRyXysBWr10Zo4GMtwDf2lNmi1Ek6nPO+6BUTqoSZ/HNPIbHutLrZ
         QP3A==
X-Forwarded-Encrypted: i=1; AJvYcCVGq4bIpbebtujDVM0czlbbiOqLWVQoEppz/Dht6AzAgeEY5YHJE72dzK/YjALoiEVKLKmj31IrfRajHfT1yYESFNPddGkFKQHymN3POQNXlgpWKeY=
X-Gm-Message-State: AOJu0YxOs4YaGrRFj+xQzF3jwphIcSTQkCr9iVmka4qLmz6Vnl5B519S
	gXE4Xzw2tpdTuVcjt+iZ4u3AZxhzZu/zR9UYFdAeXJt1QcKdMRhbHtKuIuxw6CCT1sjo6+lMGTR
	0BNVbOwwwA1z9I8tGD358bC5XMr12g0V46Db6zg==
X-Google-Smtp-Source: AGHT+IGUhuSDcmhTS+/razLCO/1gDL7CnwV2i1wH/bDjrAyZwQZkZgF9TtNyZWgqyA6hv3N+hAW/+QVNimgN+Foo0O0=
X-Received: by 2002:a05:690c:112:b0:618:8390:341f with SMTP id
 00721157ae682-622aff42b9amr2039527b3.1.1715275238457; Thu, 09 May 2024
 10:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <17CCF08ED1ED8647.29739@lists.yoctoproject.org>
 <CAOU5ZMuzwmC_BAZGGgG+5+Ejy6O5XvqUuz+07zZMNhwQ0X541g@mail.gmail.com> <d1d75d86-b72d-464e-8405-99d19619c685@windriver.com>
In-Reply-To: <d1d75d86-b72d-464e-8405-99d19619c685@windriver.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Thu, 9 May 2024 11:20:27 -0600
Message-ID: <CAOU5ZMuMdyrnmHTKi9i9E7QCFbQdHAGddYd-knVB-Pnc3MUssg@mail.gmail.com>
Subject: Re: [yocto-patches] [ptest-runner 1/2] utils.c: run-ptests improve
 pseudo-terminal handling
To: Changqing Li <changqing.li@windriver.com>, yocto-patches@lists.yoctoproject.org
Cc: randy.macleod@windriver.com
Content-Type: multipart/alternative; boundary="00000000000047e3e9061808a36a"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 09 May 2024 17:20:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/115

--00000000000047e3e9061808a36a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Awesome!, pushing the changes to master.

Cheers!,
Anibal

On Tue, May 7, 2024 at 7:39=E2=80=AFPM Changqing Li via lists.yoctoproject.=
org <
changqing.li=3Deng.windriver.com@lists.yoctoproject.org> wrote:

>
> On 5/6/24 23:44, Anibal Limon wrote:
>
> *CAUTION: This email comes from a non Wind River email account!*
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
> Hi Changqing,
>
> I spent some time reviewing the patch and this is a reduced version of it=
,
>
> If the parent set up a pty and then set up the child as stdin, It all
> needs to cover your case and previous cases raised by Randy.
>
> I tested the libtevent ptest and passed the 3 tests with this patch.
>
> Regards!,
> Anibal
>
> Hi, Anibal
>
> I am fine with this change, also try to run ptest for libtevent and bash,
> works as expect.
>
> Regards
>
> Changqing
>
>
> On Mon, May 6, 2024 at 9:40=E2=80=AFAM Anibal Limon via lists.yoctoprojec=
t.org
> <https://urldefense.com/v3/__http://lists.yoctoproject.org__;!!AjveYdw8Ev=
Q!eVbZXGRCp4bk_15nIgzDv0PrX-TJJz4iqyzoaBBkeMbiEdMJqGRZCXHery36kMYVbaHJEwYmR=
F_Ith-cM35U6kMg_eyi$>
> <anibal=3Dlimonsoftware.com@lists.yoctoproject.org> wrote:
>
>> Setup master and slave pty before run ptest, on child attach to the
>> slave pty and set it as controlling tty and stdin.
>>
>> See rev 59381a643e1fcce9b6920cb59af9402dd5eb0dfb .
>>
>> Co-authored-by: Changqing Li <changqing.li@windriver.com>
>> Signed-off-by: Anibal Limon <anibal@limonsoftware.com>
>> ---
>>  utils.c | 90 ++++++++++++---------------------------------------------
>>  1 file changed, 19 insertions(+), 71 deletions(-)
>>
>> diff --git a/utils.c b/utils.c
>> index 46918f4..3a35313 100644
>> --- a/utils.c
>> +++ b/utils.c
>> @@ -341,53 +341,6 @@ run_child(char *run_ptest, int fd_stdout, int
>> fd_stderr)
>>         /* exit(1); not needed? */
>>  }
>>
>> -/* Returns an integer file descriptor.
>> - * If it returns < 0, an error has occurred.
>> - * Otherwise, it has returned the slave pty file descriptor.
>> - * fp should be writable, likely stdout/err.
>> - */
>> -static int
>> -setup_slave_pty(FILE *fp) {
>> -       int pty_master =3D -1;
>> -       int pty_slave =3D -1;
>> -       char pty_name[256];
>> -       struct group *gptr;
>> -       gid_t gid;
>> -       int slave =3D -1;
>> -
>> -       if (openpty(&pty_master, &pty_slave, pty_name, NULL, NULL) < 0) =
{
>> -               fprintf(fp, "ERROR: openpty() failed with: %s.\n",
>> strerror(errno));
>> -               return -1;
>> -       }
>> -
>> -       if ((gptr =3D getgrnam(pty_name)) !=3D 0) {
>> -               gid =3D gptr->gr_gid;
>> -       } else {
>> -               /* If the tty group does not exist, don't change the
>> -                * group on the slave pty, only the owner
>> -                */
>> -               gid =3D (gid_t)-1;
>> -       }
>> -
>> -       /* chown/chmod the corresponding pty, if possible.
>> -        * This will only work if the process has root permissions.
>> -        */
>> -       if (chown(pty_name, getuid(), gid) !=3D 0) {
>> -               fprintf(fp, "ERROR; chown() failed with: %s.\n",
>> strerror(errno));
>> -       }
>> -
>> -       /* Makes the slave read/writeable for the user. */
>> -       if (chmod(pty_name, S_IRUSR|S_IWUSR) !=3D 0) {
>> -               fprintf(fp, "ERROR: chmod() failed with: %s.\n",
>> strerror(errno));
>> -       }
>> -
>> -       if ((slave =3D open(pty_name, O_RDWR)) =3D=3D -1) {
>> -               fprintf(fp, "ERROR: open() failed with: %s.\n",
>> strerror(errno));
>> -       }
>> -       return (slave);
>> -}
>> -
>> -
>>  int
>>  run_ptests(struct ptest_list *head, const struct ptest_options opts,
>>                 const char *progname, FILE *fp, FILE *fp_stderr)
>> @@ -406,16 +359,12 @@ run_ptests(struct ptest_list *head, const struct
>> ptest_options opts,
>>
>>         do
>>         {
>> -               if (isatty(0) && ioctl(0, TIOCNOTTY) =3D=3D -1) {
>> -                       fprintf(fp, "ERROR: Unable to detach from
>> controlling tty, %s\n", strerror(errno));
>> -               }
>> -
>>
>>                 fprintf(fp, "START: %s\n", progname);
>>                 PTEST_LIST_ITERATE_START(head, p)
>>                         int pipefd_stdout[2] =3D {-1, -1};
>>                         int pipefd_stderr[2] =3D {-1, -1};
>> -                       int pgid =3D -1;
>> +                       int pty[2] =3D {-1, -1};
>>
>>                         if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
>>                                 rc =3D -1;
>> @@ -428,6 +377,16 @@ run_ptests(struct ptest_list *head, const struct
>> ptest_options opts,
>>                                 break;
>>                         }
>>
>> +                       if (openpty(&pty[0], &pty[1], NULL, NULL, NULL) =
<
>> 0) {
>> +                               fprintf(fp, "ERROR: openpty() failed
>> with: %s.\n", strerror(errno));
>> +                               close(pipefd_stderr[PIPE_READ]);
>> +                               close(pipefd_stderr[PIPE_WRITE]);
>> +                               close(pipefd_stdout[PIPE_READ]);
>> +                               close(pipefd_stdout[PIPE_WRITE]);
>> +                               rc =3D -1;
>> +                               break;
>> +                       }
>> +
>>                         char *ptest_dir =3D strdup(p->run_ptest);
>>                         if (ptest_dir =3D=3D NULL) {
>>                                 rc =3D -1;
>> @@ -435,38 +394,31 @@ run_ptests(struct ptest_list *head, const struct
>> ptest_options opts,
>>                         }
>>                         dirname(ptest_dir);
>>
>> -                       if ((pgid =3D getpgid(0)) =3D=3D -1) {
>> -                               fprintf(fp, "ERROR: getpgid() failed,
>> %s\n", strerror(errno));
>> -                       }
>> -
>>                         pid_t child =3D fork();
>>                         if (child =3D=3D -1) {
>>                                 fprintf(fp, "ERROR: Fork %s\n",
>> strerror(errno));
>>                                 rc =3D -1;
>>                                 break;
>>                         } else if (child =3D=3D 0) {
>> -                               int slave;
>> -
>> -                               close(0);
>>                                 /* Close read ends of the pipe */
>>                                 do_close(&pipefd_stdout[PIPE_READ]);
>>                                 do_close(&pipefd_stderr[PIPE_READ]);
>>
>> -                               if ((slave =3D setup_slave_pty(fp)) < 0)=
 {
>> -                                       fprintf(fp, "ERROR: could not
>> setup pty (%d).", slave);
>> -                               }
>> -                               if (setpgid(0,pgid) =3D=3D -1) {
>> -                                       fprintf(fp, "ERROR: setpgid()
>> failed, %s\n", strerror(errno));
>> -                               }
>> +                               /* Close master pty and set slave pty as
>> stdin */
>> +                               do_close(&pty[0]);
>>
>>                                 if (setsid() =3D=3D  -1) {
>>                                         fprintf(fp, "ERROR: setsid()
>> failed, %s\n", strerror(errno));
>>                                 }
>> -
>> -                               if (ioctl(0, TIOCSCTTY, NULL) =3D=3D -1)=
 {
>> +                               if (ioctl(pty[1], TIOCSCTTY, NULL) =3D=
=3D -1)
>> {
>>                                         fprintf(fp, "ERROR: Unable to
>> attach to controlling tty, %s\n", strerror(errno));
>>                                 }
>>
>> +                               if (dup2(pty[1], STDIN_FILENO) < 0) {
>> +                                       fprintf(fp, "ERROR: Unable to du=
p
>> slave pty to stdin, %s\n", strerror(errno));
>> +                               }
>> +                               do_close(&pty[1]);
>> +
>>                                 if (chdir(ptest_dir) =3D=3D -1) {
>>                                         fprintf(fp, "ERROR: Unable to
>> chdir(%s), %s\n", ptest_dir, strerror(errno));
>>                                 } else {
>> @@ -481,10 +433,6 @@ run_ptests(struct ptest_list *head, const struct
>> ptest_options opts,
>>                                 do_close(&pipefd_stdout[PIPE_WRITE]);
>>                                 do_close(&pipefd_stderr[PIPE_WRITE]);
>>
>> -                               if (setpgid(child, pgid) =3D=3D -1) {
>> -                                       fprintf(fp, "ERROR: setpgid()
>> failed, %s\n", strerror(errno));
>> -                               }
>> -
>>                                 time_t start_time=3D time(NULL);
>>                                 fprintf(fp, "%s\n", get_stime(stime,
>> GET_STIME_BUF_SIZE, start_time));
>>                                 fprintf(fp, "BEGIN: %s\n", ptest_dir);
>> --
>> 2.43.0
>>
>>
>>
>>
>>
>>
>> _._,_._,_
> ------------------------------
> Links:
>
> You receive all messages sent to this group.
>
> View/Reply Online (#88)
> <https://lists.yoctoproject.org/g/yocto-patches/message/88> | Reply To
> Group
> <yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re%3A%20%5Byocto-pa=
tches%5D%20%5Bptest-runner%201%2F2%5D%20utils.c%3A%20run-ptests%20improve%2=
0pseudo-terminal%20handling>
> | Reply To Sender
> <changqing.li@eng.windriver.com?subject=3DPrivate:%20Re:%20Re%3A%20%5Byoc=
to-patches%5D%20%5Bptest-runner%201%2F2%5D%20utils.c%3A%20run-ptests%20impr=
ove%20pseudo-terminal%20handling>
> | Mute This Topic <https://lists.yoctoproject.org/mt/105941917/8181911> |=
 New
> Topic <https://lists.yoctoproject.org/g/yocto-patches/post>
> Your Subscription
> <https://lists.yoctoproject.org/g/yocto-patches/editsub/8181911> | Contac=
t
> Group Owner <yocto-patches+owner@lists.yoctoproject.org> | Unsubscribe
> <https://lists.yoctoproject.org/g/yocto-patches/leave/13235916/8181911/17=
931940/xyzzy>
> [anibal@limonsoftware.com]
> _._,_._,_
>
>

--00000000000047e3e9061808a36a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Awesome!, pushing the changes to master.</div><div><b=
r></div>Cheers!,<div>Anibal</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, May 7, 2024 at 7:39=E2=80=AFPM Cha=
ngqing Li via <a href=3D"http://lists.yoctoproject.org">lists.yoctoproject.=
org</a> &lt;<a href=3D"http://changqing.li">changqing.li</a>=3D<a href=3D"m=
ailto:eng.windriver.com@lists.yoctoproject.org">eng.windriver.com@lists.yoc=
toproject.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><u></u>

 =20
  <div bgcolor=3D"#cceed0">
    <p><br>
    </p>
    <div>On 5/6/24 23:44, Anibal Limon wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <strong>
      </strong>
      <div style=3D"border:1pt solid rgb(156,101,0);padding:2pt;background:=
rgb(252,252,3)"><strong><u></u><span style=3D"font-size:11pt;color:rgb(0,0,=
0)">CAUTION: This email
              comes from a non Wind River email account!</span><u></u></str=
ong><br>
        <u></u><span style=3D"font-size:10pt;color:rgb(0,0,0)">Do not click=
 links or open
            attachments unless you recognize the sender and know the
            content is safe.</span><br>
        <u></u></div>
      <div>
        <div dir=3D"ltr">Hi Changqing,
          <div><br>
          </div>
          <div>I spent some time reviewing the patch and this is a
            reduced version of it,</div>
          <div><br>
          </div>
          <div>If the parent set up a pty and then set up the child as
            stdin, It all needs to cover your case and previous cases
            raised by Randy.</div>
          <div><br>
          </div>
          <div>I tested the libtevent ptest and passed the 3 tests with
            this patch.</div>
          <div><br>
          </div>
          <div>Regards!,</div>
          <div>Anibal</div>
        </div>
      </div>
    </blockquote>
    <p>Hi, Anibal</p>
    <p>I am fine with this change, also try to run ptest for libtevent
      and bash, works as expect.</p>
    <p>Regards</p>
    <p>Changqing<br>
    </p>
    <blockquote type=3D"cite">
      <div>
        <div dir=3D"ltr">
        </div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 6, 2024 at
            9:40=E2=80=AFAM Anibal Limon via
            <a href=3D"https://urldefense.com/v3/__http://lists.yoctoprojec=
t.org__;!!AjveYdw8EvQ!eVbZXGRCp4bk_15nIgzDv0PrX-TJJz4iqyzoaBBkeMbiEdMJqGRZC=
XHery36kMYVbaHJEwYmRF_Ith-cM35U6kMg_eyi$" target=3D"_blank">
              lists.yoctoproject.org</a> &lt;anibal=3D<a href=3D"mailto:lim=
onsoftware.com@lists.yoctoproject.org" target=3D"_blank">limonsoftware.com@=
lists.yoctoproject.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            Setup master and slave pty before run ptest, on child attach
            to the<br>
            slave pty and set it as controlling tty and stdin.<br>
            <br>
            See rev 59381a643e1fcce9b6920cb59af9402dd5eb0dfb .<br>
            <br>
            Co-authored-by: Changqing Li &lt;<a href=3D"mailto:changqing.li=
@windriver.com" target=3D"_blank">changqing.li@windriver.com</a>&gt;<br>
            Signed-off-by: Anibal Limon &lt;<a href=3D"mailto:anibal@limons=
oftware.com" target=3D"_blank">anibal@limonsoftware.com</a>&gt;<br>
            ---<br>
            =C2=A0utils.c | 90
            ++++++++++++---------------------------------------------<br>
            =C2=A01 file changed, 19 insertions(+), 71 deletions(-)<br>
            <br>
            diff --git a/utils.c b/utils.c<br>
            index 46918f4..3a35313 100644<br>
            --- a/utils.c<br>
            +++ b/utils.c<br>
            @@ -341,53 +341,6 @@ run_child(char *run_ptest, int
            fd_stdout, int fd_stderr)<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* exit(1); not needed? */<br>
            =C2=A0}<br>
            <br>
            -/* Returns an integer file descriptor.<br>
            - * If it returns &lt; 0, an error has occurred.<br>
            - * Otherwise, it has returned the slave pty file
            descriptor.<br>
            - * fp should be writable, likely stdout/err.<br>
            - */<br>
            -static int<br>
            -setup_slave_pty(FILE *fp) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0int pty_master =3D -1;<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0int pty_slave =3D -1;<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0char pty_name[256];<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0struct group *gptr;<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0gid_t gid;<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0int slave =3D -1;<br>
            -<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (openpty(&amp;pty_master, &amp;p=
ty_slave,
            pty_name, NULL, NULL) &lt; 0) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf=
(fp, &quot;ERROR: openpty() failed with:
            %s.\n&quot;, strerror(errno));<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
-1;<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            -<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((gptr =3D getgrnam(pty_name)) !=
=3D 0) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gid =3D=
 gptr-&gt;gr_gid;<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If t=
he tty group does not exist, don&#39;t
            change the<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * grou=
p on the slave pty, only the owner<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gid =3D=
 (gid_t)-1;<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            -<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* chown/chmod the corresponding pt=
y, if possible.<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * This will only work if the proce=
ss has root
            permissions.<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (chown(pty_name, getuid(), gid) =
!=3D 0) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf=
(fp, &quot;ERROR; chown() failed with:
            %s.\n&quot;, strerror(errno));<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            -<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Makes the slave read/writeable f=
or the user. */<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (chmod(pty_name, S_IRUSR|S_IWUSR=
) !=3D 0) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf=
(fp, &quot;ERROR: chmod() failed with:
            %s.\n&quot;, strerror(errno));<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            -<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((slave =3D open(pty_name, O_RDW=
R)) =3D=3D -1) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf=
(fp, &quot;ERROR: open() failed with:
            %s.\n&quot;, strerror(errno));<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0return (slave);<br>
            -}<br>
            -<br>
            -<br>
            =C2=A0int<br>
            =C2=A0run_ptests(struct ptest_list *head, const struct
            ptest_options opts,<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const c=
har *progname, FILE *fp, FILE
            *fp_stderr)<br>
            @@ -406,16 +359,12 @@ run_ptests(struct ptest_list *head,
            const struct ptest_options opts,<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 do<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (isa=
tty(0) &amp;&amp; ioctl(0, TIOCNOTTY)
            =3D=3D -1) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0fprintf(fp, &quot;ERROR: Unable to detach
            from controlling tty, %s\n&quot;, strerror(errno));<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            -<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf=
(fp, &quot;START: %s\n&quot;, progname);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PTEST_L=
IST_ITERATE_START(head, p)<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 int pipefd_stdout[2] =3D {-1, -1};<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0int pgid =3D -1;<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0int pty[2] =3D {-1, -1};<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (pipe2(pipefd_stdout, 0) =3D=3D -1) {<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D -1;<br>
            @@ -428,6 +377,16 @@ run_ptests(struct ptest_list *head,
            const struct ptest_options opts,<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 }<br>
            <br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if (openpty(&amp;pty[0],
            &amp;pty[1], NULL, NULL, NULL) &lt; 0) {<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp, &quot;ERROR:
            openpty() failed with: %s.\n&quot;, strerror(errno));<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0close(pipefd_stderr[PIPE_READ]);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0close(pipefd_stderr[PIPE_WRITE]);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0close(pipefd_stdout[PIPE_READ]);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            =C2=A0close(pipefd_stdout[PIPE_WRITE]);<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D -1;<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 char *ptest_dir =3D
            strdup(p-&gt;run_ptest);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (ptest_dir =3D=3D NULL) {<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D -1;<br>
            @@ -435,38 +394,31 @@ run_ptests(struct ptest_list *head,
            const struct ptest_options opts,<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 }<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dirname(ptest_dir);<br>
            <br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0if ((pgid =3D getpgid(0)) =3D=3D -1) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp, &quot;ERROR:
            getpgid() failed, %s\n&quot;, strerror(errno));<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br>
            -<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 pid_t child =3D fork();<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (child =3D=3D -1) {<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;ERROR: F=
ork
            %s\n&quot;, strerror(errno));<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D -1;<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 } else if (child =3D=3D 0) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int slave;<br>
            -<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(0);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Close read ends of the
            pipe */<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            do_close(&amp;pipefd_stdout[PIPE_READ]);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            do_close(&amp;pipefd_stderr[PIPE_READ]);<br>
            <br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((slave =3D
            setup_slave_pty(fp)) &lt; 0) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fprintf(fp, &quot;ERROR:
            could not setup pty (%d).&quot;, slave);<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (setpgid(0,pgid) =3D=3D=
 -1) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fprintf(fp, &quot;ERROR:
            setpgid() failed, %s\n&quot;, strerror(errno));<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Close master pty and se=
t
            slave pty as stdin */<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_close(&amp;pty[0]);<br>
            <br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (setsid() =3D=3D=C2=A0 =
-1) {<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 fprintf(fp, &quot;ERROR:
            setsid() failed, %s\n&quot;, strerror(errno));<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
            -<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(0, TIOCSCTTY,
            NULL) =3D=3D -1) {<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(pty[1], TIOCSCTT=
Y,
            NULL) =3D=3D -1) {<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 fprintf(fp, &quot;ERROR:
            Unable to attach to controlling tty, %s\n&quot;,
            strerror(errno));<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
            <br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dup2(pty[1],
            STDIN_FILENO) &lt; 0) {<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fprintf(fp, &quot;ERROR:
            Unable to dup slave pty to stdin, %s\n&quot;, strerror(errno));=
<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_close(&amp;pty[1]);<br>
            +<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (chdir(ptest_dir) =3D=
=3D -1)
            {<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 fprintf(fp, &quot;ERROR:
            Unable to chdir(%s), %s\n&quot;, ptest_dir, strerror(errno));<b=
r>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
            @@ -481,10 +433,6 @@ run_ptests(struct ptest_list *head,
            const struct ptest_options opts,<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            do_close(&amp;pipefd_stdout[PIPE_WRITE]);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
            do_close(&amp;pipefd_stderr[PIPE_WRITE]);<br>
            <br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (setpgid(child, pgid) =
=3D=3D
            -1) {<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fprintf(fp, &quot;ERROR:
            setpgid() failed, %s\n&quot;, strerror(errno));<br>
            -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            -<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time_t start_time=3D
            time(NULL);<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;%s\n&quo=
t;,
            get_stime(stime, GET_STIME_BUF_SIZE, start_time));<br>
            =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;BEGIN: %=
s\n&quot;,
            ptest_dir);<br>
            -- <br>
            2.43.0<br>
            <br>
            <br>
            <br>
            <br>
            <br>
            <br>
          </blockquote>
        </div>
       =20
      </div>
    </blockquote>
  </div>



<div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>
<hr>


Links:<p>


 =20
    You receive all messages sent to this group.
 =20
 =20


</p><p>
<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/message/88" targe=
t=3D"_blank">View/Reply Online (#88)</a> |


  <a href=3D"mailto:yocto-patches@lists.yoctoproject.org?subject=3DRe:%20Re=
%3A%20%5Byocto-patches%5D%20%5Bptest-runner%201%2F2%5D%20utils.c%3A%20run-p=
tests%20improve%20pseudo-terminal%20handling" target=3D"_blank">Reply To Gr=
oup</a>
 =20
    | <a href=3D"mailto:changqing.li@eng.windriver.com?subject=3DPrivate:%2=
0Re:%20Re%3A%20%5Byocto-patches%5D%20%5Bptest-runner%201%2F2%5D%20utils.c%3=
A%20run-ptests%20improve%20pseudo-terminal%20handling" target=3D"_blank">Re=
ply To Sender</a>
 =20

|

  <a href=3D"https://lists.yoctoproject.org/mt/105941917/8181911" target=3D=
"_blank">Mute This Topic</a>


| <a href=3D"https://lists.yoctoproject.org/g/yocto-patches/post" target=3D=
"_blank">New Topic</a>

<br>




<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/editsub/8181911" =
target=3D"_blank">Your Subscription</a> |
<a href=3D"mailto:yocto-patches+owner@lists.yoctoproject.org" target=3D"_bl=
ank">Contact Group Owner</a> |

<a href=3D"https://lists.yoctoproject.org/g/yocto-patches/leave/13235916/81=
81911/17931940/xyzzy" target=3D"_blank">Unsubscribe</a>

 [<a href=3D"mailto:anibal@limonsoftware.com" target=3D"_blank">anibal@limo=
nsoftware.com</a>]<br>
</p><div width=3D"1" style=3D"color:white;clear:both">_._,_._,_</div>

<p></p><p></p></blockquote></div>

--00000000000047e3e9061808a36a--

