Return-Path: <anibal@limonsoftware.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC4C4345F
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 22:42:41 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
 by mx.groups.io with SMTP id smtpd.web10.8092.1714689758132277496
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 02 May 2024 15:42:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@limonsoftware-com.20230601.gappssmtp.com header.s=20230601 header.b=mIQ0A3KX;
 spf=pass (domain: limonsoftware.com, ip: 209.85.128.174, mailfrom: anibal@limonsoftware.com)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-61bed738438so35158827b3.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 02 May 2024 15:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=limonsoftware-com.20230601.gappssmtp.com; s=20230601; t=1714689757; x=1715294557; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UnAJGZg9wncILMSGE/qC042BD8BEKU03B4q1WMuH7Lw=;
        b=mIQ0A3KXGNNV0+vyBAJEr5vWH+iTBoR5eCG7m32iDAljKycOtsz90koPrSrWdbUyG+
         EVPmSQiydCd9GDD5+t5Tm98SxS8THeBg/bzqDBsJItYY2yjTrGwKpPydHYdXvorF4Qx1
         y4GWhU+333odSlkFy78y+pcQwQMIKeVOAT2miIeePd7XR3Nd8RlcSM4cD+lOiutSUa7d
         N8JIiuvI1QgVXRiFOCbBzO1eUfbklBy9JcYGeHeloL0FujAxAsJlQJMSEtkd0e8DfClr
         mEwiSbfJNQHgBP8HmvKyVzd+KuY+buBlY2jI9+PFgHM/qefMkb6BwwEvtfdLnBA3wjJO
         LNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689757; x=1715294557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UnAJGZg9wncILMSGE/qC042BD8BEKU03B4q1WMuH7Lw=;
        b=CnZxtz34+NmB+9cIBFjgbykGKNi2mF6agSseswjze5prhT7tYC/vXN8C8yS+xZA0KR
         u8W0A4KcaTxG2mIBNHsdxXa5oPDmctbgShFMCiKB47SrzTlPupDUF6WfJvMQXbJfjTdN
         3DjqvXbRmRyqiU/WP+slxvtX99g08APi3m4dgt9/cguSIkszj97rHbjEr8SRAReXh5Qp
         KIaCNmbB4uJPdH+sz4HOVMfR64uFsF2DYY6hQHkqvLUxI1caTYWHbliHSb0jPFwbfG3d
         aY6/gt8x2IfiI4C8boc7QxvPLRkOtG7C60leLUjzAi8qyGjtu+y78JFjRdf4EfegTYbm
         ayDQ==
X-Gm-Message-State: AOJu0YxFe7jlzH0Tm5dKul9nlI6i3CD9TjnlB9/1YPqoEaJFHhUBW0SZ
	FQEOpls5Y1vr32a0Ul+dDug7+n+VPKjfzwz7CUgrCmzY6GMNnpEqfaYEyj4FlgofbyfkjeHVgHM
	iC+HFc0smOmAE4vR7NY8le+ijk4ZA9qknIcTRww==
X-Google-Smtp-Source: AGHT+IE96DOwu5yIAPiYQDYwzqJsVnWM8TtFZTfW5Hy5cejqpv6PavUafoEQOkCWfzSy/t2jNPFzGCDR8KGn6N5WYhA=
X-Received: by 2002:a05:690c:399:b0:610:cd34:439e with SMTP id
 bh25-20020a05690c039900b00610cd34439emr1021632ywb.49.1714689757202; Thu, 02
 May 2024 15:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240425014728.4070856-1-changqing.li@windriver.com>
 <CAOU5ZMue2AZxq_7fJTVn6LEXPPXWrn-D7UFdzX43xvvJV6yQEA@mail.gmail.com> <abab1e79-ca87-4544-a317-931c84738b88@windriver.com>
In-Reply-To: <abab1e79-ca87-4544-a317-931c84738b88@windriver.com>
From: Anibal Limon <anibal@limonsoftware.com>
Date: Thu, 2 May 2024 16:42:25 -0600
Message-ID: <CAOU5ZMtLFy-5opXW58Fp5Qpdeo8+t8BkTZBgSFzAjFGGXPhboQ@mail.gmail.com>
Subject: Re: [PATCH V2] utils.c: fix pty setup
To: Changqing Li <changqing.li@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
Content-Type: multipart/alternative; boundary="000000000000e0ea0e06178051be"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 02 May 2024 22:42:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/80

--000000000000e0ea0e06178051be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Changqing,

I ran the test suite and it looks good so far.
I will run more tests before pushing this + minor changes may be.

Thanks!,
Anibal

On Thu, Apr 25, 2024 at 7:22=E2=80=AFPM Changqing Li <changqing.li@windrive=
r.com>
wrote:

>
> On 4/26/24 05:59, Anibal Limon wrote:
>
> *CAUTION: This email comes from a non Wind River email account!*
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
> Comments below,
>
> Thanks!,
> Anibal
>
> On Wed, Apr 24, 2024 at 7:47=E2=80=AFPM <changqing.li@windriver.com> wrot=
e:
>
>> From: Changqing Li <changqing.li@windriver.com>
>>
>> subcase test_tevent_trace will fail if run libtevent-ptest with
>> ptest-runner, but if run directly, the subcase can successfully.
>>
>> The failure related to how pty is setup:
>> In child progress, after close(0), the master pty will use 0 as file
>> descriptors, and then master pty is attched as child stdin, and slave
>> pty will also be closed by func close_fds. This will make epoll_wait
>> will get signal EPOLLHUP, then test failed.
>>
>> Refer:
>> epoll_wait(3, [{events=3DEPOLLOUT|EPOLLHUP, data=3D{u32=3D2625883648,
>> u64=3D94496201362944}}], 1, 30000) =3D 1
>>
>> lrwx------ 1 root root 64 Apr 23 01:08 0 -> /dev/ptmx
>> l-wx------ 1 root root 64 Apr 23 01:08 1 -> 'pipe:[4261]'
>> l-wx------ 1 root root 64 Apr 23 01:08 2 -> 'pipe:[4261]'
>>
>> To fix this:
>> 1. Open master pty in parent process
>> 2. Attach slave pty to child stdin
>> 3. Remove detaching controlling tty from parent process
>> 4. Remove seting process groupid for child process
>>
>> Refer:
>> lrwx------ 1 root root 64 Apr 23 07:35 0 -> /dev/pts/0
>> l-wx------ 1 root root 64 Apr 23 07:35 1 -> 'pipe:[37001]'
>> l-wx------ 1 root root 64 Apr 23 07:35 2 -> 'pipe:[37001]'
>>
>> Signed-off-by: Changqing Li <changqing.li@windriver.com>
>> ---
>>  utils.c | 67 ++++++++++++++++++++++++++++++++-------------------------
>>  1 file changed, 38 insertions(+), 29 deletions(-)
>>
>> diff --git a/utils.c b/utils.c
>> index 46918f4..6b3a492 100644
>> --- a/utils.c
>> +++ b/utils.c
>> @@ -341,25 +341,31 @@ run_child(char *run_ptest, int fd_stdout, int
>> fd_stderr)
>>         /* exit(1); not needed? */
>>  }
>>
>> +/* Returns an integer.
>> + * If it returns < 0, an error has occurred.
>> + * Otherwise, return 0 means successfully
>> + * fp should be writable, likely stdout/err.
>> + */
>> +static int
>> +setup_master_pty(int* pty_master, int* pty_slave, char*pty_name, FILE
>> *fp) {
>> +       if (openpty(pty_master, pty_slave, pty_name, NULL, NULL) < 0) {
>> +               fprintf(fp, "ERROR: openpty() failed with: %s.\n",
>> strerror(errno));
>> +               return -1;
>> +       }
>> +       return 0;
>> +}
>> +
>>  /* Returns an integer file descriptor.
>>   * If it returns < 0, an error has occurred.
>>   * Otherwise, it has returned the slave pty file descriptor.
>>   * fp should be writable, likely stdout/err.
>>   */
>>  static int
>> -setup_slave_pty(FILE *fp) {
>> -       int pty_master =3D -1;
>> -       int pty_slave =3D -1;
>> -       char pty_name[256];
>> +setup_slave_pty(char* pty_name, FILE *fp) {
>>         struct group *gptr;
>>         gid_t gid;
>>         int slave =3D -1;
>>
>> -       if (openpty(&pty_master, &pty_slave, pty_name, NULL, NULL) < 0) =
{
>> -               fprintf(fp, "ERROR: openpty() failed with: %s.\n",
>> strerror(errno));
>> -               return -1;
>> -       }
>> -
>>         if ((gptr =3D getgrnam(pty_name)) !=3D 0) {
>>                 gid =3D gptr->gr_gid;
>>         } else {
>> @@ -384,9 +390,9 @@ setup_slave_pty(FILE *fp) {
>>         if ((slave =3D open(pty_name, O_RDWR)) =3D=3D -1) {
>>                 fprintf(fp, "ERROR: open() failed with: %s.\n",
>> strerror(errno));
>>         }
>> -       return (slave);
>> -}
>>
>> +       return slave;
>> +}
>>
>>  int
>>  run_ptests(struct ptest_list *head, const struct ptest_options opts,
>> @@ -406,16 +412,13 @@ run_ptests(struct ptest_list *head, const struct
>> ptest_options opts,
>>
>>         do
>>         {
>> -               if (isatty(0) && ioctl(0, TIOCNOTTY) =3D=3D -1) {
>> -                       fprintf(fp, "ERROR: Unable to detach from
>> controlling tty, %s\n", strerror(errno));
>> -               }
>> -
>> -
>>                 fprintf(fp, "START: %s\n", progname);
>>                 PTEST_LIST_ITERATE_START(head, p)
>>                         int pipefd_stdout[2] =3D {-1, -1};
>>                         int pipefd_stderr[2] =3D {-1, -1};
>> -                       int pgid =3D -1;
>> +                       int pty_master =3D -1;
>> +                       int pty_slave =3D -1;
>> +                       char pty_name[256] =3D {0};
>>
>>                         if (pipe2(pipefd_stdout, 0) =3D=3D -1) {
>>                                 rc =3D -1;
>> @@ -435,8 +438,9 @@ run_ptests(struct ptest_list *head, const struct
>> ptest_options opts,
>>                         }
>>                         dirname(ptest_dir);
>>
>> -                       if ((pgid =3D getpgid(0)) =3D=3D -1) {
>> -                               fprintf(fp, "ERROR: getpgid() failed,
>> %s\n", strerror(errno));
>>
>
> This comes from Randy patch to ensure child tests are in the same process
> group than the ptest-runner, 59381a64. Any specific reason to remove this=
?.
>
> See blow comments where pgid is used.
>
>
>
>> +                       if (setup_master_pty(&pty_master, &pty_slave,
>> pty_name, fp) < 0) {
>> +                               fprintf(fp, "ERROR: setup_master_pty
>> failed, %s\n", strerror(errno));
>> +                               break;
>>                         }
>>
>>                         pid_t child =3D fork();
>> @@ -447,25 +451,32 @@ run_ptests(struct ptest_list *head, const struct
>> ptest_options opts,
>>                         } else if (child =3D=3D 0) {
>>                                 int slave;
>>
>> -                               close(0);
>>                                 /* Close read ends of the pipe */
>>                                 do_close(&pipefd_stdout[PIPE_READ]);
>>                                 do_close(&pipefd_stderr[PIPE_READ]);
>> +                               do_close(&pty_master);
>>
>> -                               if ((slave =3D setup_slave_pty(fp)) < 0)=
 {
>> +                               if ((slave =3D setup_slave_pty(pty_name,
>> fp)) < 0) {
>>                                         fprintf(fp, "ERROR: could not
>> setup pty (%d).", slave);
>>                                 }
>> -                               if (setpgid(0,pgid) =3D=3D -1) {
>> -                                       fprintf(fp, "ERROR: setpgid()
>> failed, %s\n", strerror(errno));
>> -                               }
>>
> The pgid is used to set child process to join the same progress group as
> parent.
>
> But next line,  we will make child as session leader,  then the child wil=
l
> also be in the new progress group.
>
> So above setpgid actually not need.  Here is the process stat with
> ptest-runner(without this patch):
>
> root@qemux86-64:~# cat /proc/455/stat
> 455 (ptest-runner) S 422 *455* 283 0 -1 4194304 109 0 0 0 0 2 0 0 20 0 1
> 0 62009 2441216 352 18446744073709551615 94258154364928 94258154373585
> 140722320232848 0 0 0 0 0 0 1 0 0 17 0 0 0 0 0 0 94258154384384
> 94258154385424 94258154389504 140722320240155 140722320240178
> 140722320240178 140722320240610 0
> root@qemux86-64:~# cat /proc/456/stat
> 456 (run-ptest) S 455 *456* 456 34817 456 4194560 242 0 0 0 0 0 0 0 20 0
> 1 0 62065 3813376 640 18446744073709551615 94612400209920 94612400903225
> 140724672843248 0 0 0 65536 4 65538 1 0 0 17 1 0 0 0 0 0 94612401150672
> 94612401198372 94612401246208 140724672851446 140724672851491
> 140724672851491 140724672851923 0
> root@qemux86-64:~#
>
> We can see,  although setpgid,  but finally,  we pgid of child will be th=
e
> child pid.
>
>
>>                                 if (setsid() =3D=3D  -1) {
>>                                         fprintf(fp, "ERROR: setsid()
>> failed, %s\n", strerror(errno));
>>                                 }
>>
>> -                               if (ioctl(0, TIOCSCTTY, NULL) =3D=3D -1)=
 {
>> +                               if (ioctl(slave, TIOCSCTTY, NULL) =3D=3D=
 -1) {
>>                                         fprintf(fp, "ERROR: Unable to
>> attach to controlling tty, %s\n", strerror(errno));
>>                                 }
>
> +                               if (slave > 2) {
>> +                                       close(slave);
>> +                               }
>> +
>> +                               if (dup2(pty_slave, STDIN_FILENO) < 0) {
>> +                                       fprintf(fp, "ERROR: Unable to du=
p
>> slave pty to stdin, %s\n", strerror(errno));
>> +                               }
>> +                               if (pty_slave > 2) {
>> +                                       close(pty_slave);
>> +                               }
>>
> Which is the reason to make it twice?, and also closing with slave > 2.
>
> first,  according  to current code logic,  the slave/pty_slave should
> always > 2,  the if checking just for ensure it is.
>
> pty_slave and slave are point to slave pty,  but they have different fd.
> So I need to close them both after dup slave pty to stdin.
>
>
>
>>
>>                                 if (chdir(ptest_dir) =3D=3D -1) {
>>                                         fprintf(fp, "ERROR: Unable to
>> chdir(%s), %s\n", ptest_dir, strerror(errno));
>> @@ -481,10 +492,6 @@ run_ptests(struct ptest_list *head, const struct
>> ptest_options opts,
>>                                 do_close(&pipefd_stdout[PIPE_WRITE]);
>>                                 do_close(&pipefd_stderr[PIPE_WRITE]);
>>
>> -                               if (setpgid(child, pgid) =3D=3D -1) {
>> -                                       fprintf(fp, "ERROR: setpgid()
>> failed, %s\n", strerror(errno));
>> -                               }
>> -
>>
> Removal comment up.
>
> Same as what I comments above,  child is in another session,  so this is
> not needed.
>
>
> Regards
>
> Changqing
>
>
>
>>                                 time_t start_time=3D time(NULL);
>>                                 fprintf(fp, "%s\n", get_stime(stime,
>> GET_STIME_BUF_SIZE, start_time));
>>                                 fprintf(fp, "BEGIN: %s\n", ptest_dir);
>> @@ -608,6 +615,8 @@ run_ptests(struct ptest_list *head, const struct
>> ptest_options opts,
>>                         do_close(&pipefd_stdout[PIPE_WRITE]);
>>                         do_close(&pipefd_stderr[PIPE_READ]);
>>                         do_close(&pipefd_stderr[PIPE_WRITE]);
>> +                       do_close(&pty_master);
>> +                       do_close(&pty_slave);
>>
>>                         fflush(fp);
>>                         fflush(fp_stderr);
>> --
>> 2.25.1
>>
>>

--000000000000e0ea0e06178051be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Changqing,<div><br></div><div>I ran th=
e test suite and it looks=C2=A0good so far.=C2=A0</div><div>I will run more=
 tests before pushing this=C2=A0+ minor=C2=A0changes may be.</div><div><br>=
</div><div>Thanks!,</div><div>Anibal</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 25, 2024 at 7:22=E2=
=80=AFPM Changqing Li &lt;<a href=3D"mailto:changqing.li@windriver.com">cha=
ngqing.li@windriver.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><u></u>

 =20
  <div>
    <p><br>
    </p>
    <div>On 4/26/24 05:59, Anibal Limon wrote:<br>
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
        <div dir=3D"ltr">
          <div dir=3D"ltr">Comments below,</div>
          <div dir=3D"ltr"><br>
          </div>
          <div>Thanks!,</div>
          <div>Anibal</div>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 24, 2024 at
              7:47=E2=80=AFPM &lt;<a href=3D"mailto:changqing.li@windriver.=
com" target=3D"_blank">changqing.li@windriver.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              From: Changqing Li &lt;<a href=3D"mailto:changqing.li@windriv=
er.com" target=3D"_blank">changqing.li@windriver.com</a>&gt;<br>
              <br>
              subcase test_tevent_trace will fail if run libtevent-ptest
              with<br>
              ptest-runner, but if run directly, the subcase can
              successfully.<br>
              <br>
              The failure related to how pty is setup:<br>
              In child progress, after close(0), the master pty will use
              0 as file<br>
              descriptors, and then master pty is attched as child
              stdin, and slave<br>
              pty will also be closed by func close_fds. This will make
              epoll_wait<br>
              will get signal EPOLLHUP, then test failed.<br>
              <br>
              Refer:<br>
              epoll_wait(3, [{events=3DEPOLLOUT|EPOLLHUP,
              data=3D{u32=3D2625883648, u64=3D94496201362944}}], 1, 30000) =
=3D 1<br>
              <br>
              lrwx------ 1 root root 64 Apr 23 01:08 0 -&gt; /dev/ptmx<br>
              l-wx------ 1 root root 64 Apr 23 01:08 1 -&gt;
              &#39;pipe:[4261]&#39;<br>
              l-wx------ 1 root root 64 Apr 23 01:08 2 -&gt;
              &#39;pipe:[4261]&#39;<br>
              <br>
              To fix this:<br>
              1. Open master pty in parent process<br>
              2. Attach slave pty to child stdin<br>
              3. Remove detaching controlling tty from parent process<br>
              4. Remove seting process groupid for child process<br>
              <br>
              Refer:<br>
              lrwx------ 1 root root 64 Apr 23 07:35 0 -&gt; /dev/pts/0<br>
              l-wx------ 1 root root 64 Apr 23 07:35 1 -&gt;
              &#39;pipe:[37001]&#39;<br>
              l-wx------ 1 root root 64 Apr 23 07:35 2 -&gt;
              &#39;pipe:[37001]&#39;<br>
              <br>
              Signed-off-by: Changqing Li &lt;<a href=3D"mailto:changqing.l=
i@windriver.com" target=3D"_blank">changqing.li@windriver.com</a>&gt;<br>
              ---<br>
              =C2=A0utils.c | 67
              ++++++++++++++++++++++++++++++++-------------------------<br>
              =C2=A01 file changed, 38 insertions(+), 29 deletions(-)<br>
              <br>
              diff --git a/utils.c b/utils.c<br>
              index 46918f4..6b3a492 100644<br>
              --- a/utils.c<br>
              +++ b/utils.c<br>
              @@ -341,25 +341,31 @@ run_child(char *run_ptest, int
              fd_stdout, int fd_stderr)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* exit(1); not needed? */<br>
              =C2=A0}<br>
              <br>
              +/* Returns an integer.<br>
              + * If it returns &lt; 0, an error has occurred.<br>
              + * Otherwise, return 0 means successfully<br>
              + * fp should be writable, likely stdout/err.<br>
              + */<br>
              +static int<br>
              +setup_master_pty(int* pty_master, int* pty_slave,
              char*pty_name, FILE *fp) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (openpty(pty_master, pty_slave=
, pty_name, NULL,
              NULL) &lt; 0) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprin=
tf(fp, &quot;ERROR: openpty() failed with:
              %s.\n&quot;, strerror(errno));<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -1;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
              +}<br>
              +<br>
              =C2=A0/* Returns an integer file descriptor.<br>
              =C2=A0 * If it returns &lt; 0, an error has occurred.<br>
              =C2=A0 * Otherwise, it has returned the slave pty file
              descriptor.<br>
              =C2=A0 * fp should be writable, likely stdout/err.<br>
              =C2=A0 */<br>
              =C2=A0static int<br>
              -setup_slave_pty(FILE *fp) {<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0int pty_master =3D -1;<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0int pty_slave =3D -1;<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0char pty_name[256];<br>
              +setup_slave_pty(char* pty_name, FILE *fp) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct group *gptr;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 gid_t gid;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 int slave =3D -1;<br>
              <br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (openpty(&amp;pty_master, &amp=
;pty_slave,
              pty_name, NULL, NULL) &lt; 0) {<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprin=
tf(fp, &quot;ERROR: openpty() failed with:
              %s.\n&quot;, strerror(errno));<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retur=
n -1;<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              -<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((gptr =3D getgrnam(pty_name))=
 !=3D 0) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gid =
=3D gptr-&gt;gr_gid;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
              @@ -384,9 +390,9 @@ setup_slave_pty(FILE *fp) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((slave =3D open(pty_name, O_R=
DWR)) =3D=3D -1) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprin=
tf(fp, &quot;ERROR: open() failed with:
              %s.\n&quot;, strerror(errno));<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0return (slave);<br>
              -}<br>
              <br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0return slave;<br>
              +}<br>
              <br>
              =C2=A0int<br>
              =C2=A0run_ptests(struct ptest_list *head, const struct
              ptest_options opts,<br>
              @@ -406,16 +412,13 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              <br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 do<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i=
satty(0) &amp;&amp; ioctl(0,
              TIOCNOTTY) =3D=3D -1) {<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp, &quot;ERROR: Unable to
              detach from controlling tty, %s\n&quot;, strerror(errno));<br=
>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              -<br>
              -<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprin=
tf(fp, &quot;START: %s\n&quot;, progname);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PTEST=
_LIST_ITERATE_START(head, p)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stdout[2] =3D {-1, -1};<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 int pipefd_stderr[2] =3D {-1, -1};<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int pgid =3D -1;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int pty_master =3D -1;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int pty_slave =3D -1;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0char pty_name[256] =3D {0};<br>
              <br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 if (pipe2(pipefd_stdout, 0) =3D=3D -1)
              {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D -1;<br>
              @@ -435,8 +438,9 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 dirname(ptest_dir);<br>
              <br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if ((pgid =3D getpgid(0)) =3D=3D -1) {<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp, &quot;ERROR=
:
              getpgid() failed, %s\n&quot;, strerror(errno));<br>
            </blockquote>
            <div><br>
            </div>
            <div>This comes from Randy patch to ensure child tests are
              in the same process group than the ptest-runner,=C2=A059381a6=
4.
              Any specific reason to remove this?. <br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    See blow comments where pgid is used.<br>
    <blockquote type=3D"cite">
      <div>
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <div>=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if
              (setup_master_pty(&amp;pty_master, &amp;pty_slave,
              pty_name, fp) &lt; 0) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(fp, &quot;ERROR=
:
              setup_master_pty failed, %s\n&quot;, strerror(errno));<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
              <br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 pid_t child =3D fork();<br>
              @@ -447,25 +451,32 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 } else if (child =3D=3D 0) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int slave;<br>
              <br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0close(0);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Close read ends of =
the
              pipe */<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              do_close(&amp;pipefd_stdout[PIPE_READ]);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              do_close(&amp;pipefd_stderr[PIPE_READ]);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_close(&amp;pty_maste=
r);<br>
              <br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((slave =3D
              setup_slave_pty(fp)) &lt; 0) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((slave =3D
              setup_slave_pty(pty_name, fp)) &lt; 0) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fprintf(fp,
              &quot;ERROR: could not setup pty (%d).&quot;, slave);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (setpgid(0,pgid) =3D=
=3D -1)
              {<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0fprintf(fp,
              &quot;ERROR: setpgid() failed, %s\n&quot;, strerror(errno));<=
br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
    <p>The pgid is used to set child process to join the same progress
      group as parent.</p>
    <p>But next line,=C2=A0 we will make child as session leader,=C2=A0 the=
n the
      child will also be in the new progress group.=C2=A0 <br>
    </p>
    <p>So above setpgid actually not need.=C2=A0 Here is the process stat
      with ptest-runner(without this patch):</p>
    <p>root@qemux86-64:~# cat /proc/455/stat<br>
      455 (ptest-runner) S 422 <b>455</b> 283 0 -1 4194304 109 0 0 0 0
      2 0 0 20 0 1 0 62009 2441216 352 18446744073709551615
      94258154364928 94258154373585 140722320232848 0 0 0 0 0 0 1 0 0 17
      0 0 0 0 0 0 94258154384384 94258154385424 94258154389504
      140722320240155 140722320240178 140722320240178 140722320240610 0<br>
      root@qemux86-64:~# cat /proc/456/stat<br>
      456 (run-ptest) S 455 <b>456</b> 456 34817 456 4194560 242 0 0 0
      0 0 0 0 20 0 1 0 62065 3813376 640 18446744073709551615
      94612400209920 94612400903225 140724672843248 0 0 0 65536 4 65538
      1 0 0 17 1 0 0 0 0 0 94612401150672 94612401198372 94612401246208
      140724672851446 140724672851491 140724672851491 140724672851923 0<br>
      root@qemux86-64:~# <br>
    </p>
    <p>We can see,=C2=A0 although=C2=A0setpgid,=C2=A0 but finally,=C2=A0 we=
 pgid of child
      will be the child pid. </p>
    <blockquote type=3D"cite">
      <div>
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (setsid() =3D=3D=C2=
=A0 -1) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fprintf(fp,
              &quot;ERROR: setsid() failed, %s\n&quot;, strerror(errno));<b=
r>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
              <br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(0, TIOCSCTTY,
              NULL) =3D=3D -1) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(slave,
              TIOCSCTTY, NULL) =3D=3D -1) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fprintf(fp,
              &quot;ERROR: Unable to attach to controlling tty, %s\n&quot;,
              strerror(errno));<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }=C2=A0</blockquote>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (slave &gt; 2) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0close(slave);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              +<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dup2(pty_slave,
              STDIN_FILENO) &lt; 0) {<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0fprintf(fp,
              &quot;ERROR: Unable to dup slave pty to stdin, %s\n&quot;,
              strerror(errno));<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pty_slave &gt; 2) {=
<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0close(pty_slave);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
            </blockquote>
            <div>Which is the reason to make it twice?, and also closing
              with slave &gt; 2.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>first,=C2=A0 according=C2=A0 to current code logic,=C2=A0 the slave/=
pty_slave
      should always &gt; 2,=C2=A0 the if checking just for ensure it is.</p=
>
    <p>pty_slave and slave are point to slave pty,=C2=A0 but they have
      different fd.=C2=A0 So I need to close them both after dup slave pty =
to
      stdin.</p>
    <blockquote type=3D"cite">
      <div>
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <div>
            </div>
            <div>=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (chdir(ptest_dir) =
=3D=3D
              -1) {<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 fprintf(fp,
              &quot;ERROR: Unable to chdir(%s), %s\n&quot;, ptest_dir,
              strerror(errno));<br>
              @@ -481,10 +492,6 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              do_close(&amp;pipefd_stdout[PIPE_WRITE]);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
              do_close(&amp;pipefd_stderr[PIPE_WRITE]);<br>
              <br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (setpgid(child, pgid=
)
              =3D=3D -1) {<br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0fprintf(fp,
              &quot;ERROR: setpgid() failed, %s\n&quot;, strerror(errno));<=
br>
              -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
              -<br>
            </blockquote>
            <div>Removal comment up.</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Same as what I comments above,=C2=A0 child is in another session,=C2=
=A0 so
      this is not needed.</p>
    <p><br>
    </p>
    <p>Regards</p>
    <p>Changqing<br>
    </p>
    <blockquote type=3D"cite">
      <div>
        <div dir=3D"ltr">
          <div class=3D"gmail_quote">
            <div>=C2=A0</div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 time_t start_time=3D
              time(NULL);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;%s\n=
&quot;,
              get_stime(stime, GET_STIME_BUF_SIZE, start_time));<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(fp, &quot;BEGI=
N: %s\n&quot;,
              ptest_dir);<br>
              @@ -608,6 +615,8 @@ run_ptests(struct ptest_list *head,
              const struct ptest_options opts,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
              do_close(&amp;pipefd_stdout[PIPE_WRITE]);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
              do_close(&amp;pipefd_stderr[PIPE_READ]);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0
              do_close(&amp;pipefd_stderr[PIPE_WRITE]);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0do_close(&amp;pty_master);<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0do_close(&amp;pty_slave);<br>
              <br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 fflush(fp);<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 fflush(fp_stderr);<br>
              -- <br>
              2.25.1<br>
              <br>
            </blockquote>
          </div>
        </div>
      </div>
    </blockquote>
  </div>

</blockquote></div></div>

--000000000000e0ea0e06178051be--

