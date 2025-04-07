Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47021C3601A
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 07:27:47 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web10.41354.1744010857845010012
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Apr 2025 00:27:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DWhPDiIm;
 spf=pass (domain: gmail.com, ip: 209.85.208.170, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf8632052so35986131fa.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744010856; x=1744615656; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUzbKO6HQs+cPKmTNw9YraXQdaGZ4Z741ooPkomUYs0=;
        b=DWhPDiImJjMjtjRo5KbdES2YnXYiRh+vmW2zpIZxlTzovavMHZzKTGPzT7CeV1AP6s
         8J2+mFUzdggTY5cYsCC0hRgclBPH06iD3JORZRjgG4zhmfkk9Nhr6o2YLVej2iFke/YF
         qbmI+O5ZfXXpNcFRtJzZUrpkD81aWvdK3gyksLH42V+9cNjsSMTBWz+8O4SNvqspH9QL
         M2g21a+twtOgJZGERhNThrL+Y4HFi2CCz3z/kr26YHHAqRvBMdLXoEYhVRqmX5oUYBHy
         uLxU0Pb3WAy2dgzUEoFiXqwZMW+j+0QInnfIkgJ4BlvIKsqaFka/mSASZ2gu2vh0ymtW
         Z8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744010856; x=1744615656;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUzbKO6HQs+cPKmTNw9YraXQdaGZ4Z741ooPkomUYs0=;
        b=GJY9wH24Zhnnf60lZ75nX/FWCtsxQx4xRNx4r28hPskTJudAAgkwf+klSnNFvAC0ME
         O30rFdxbluXbm3AWO2mGJviSRwhuclGkkEIBrr+7Nu9FV6Nf11CiqJxLq9H2rzj43O4i
         Ldv45/uHbQ4jtccU4sQAuOuN6dlKg+cuTLNy2A5qUuoWo+FXoG9rjzvvu9xYMxqLf/Eo
         gS8Mj+RbEjKvewhAH37MgGUmKFruBi8Mjlufb646/2+Nyp3LMmS00EKhmJ+xygdDLoM8
         acPSmsH3971Drh7qAAlyQYKcrJET5I9yw4rIZ+O6a9U0SMoHrE1WWeTNtbDHh8/1zwhf
         D6FQ==
X-Gm-Message-State: AOJu0YzOrd1HPd82xTfAMsLjdkDuctgxOg0EswrwcgUy4+flCjOm1eQy
	hx41owZZyCm5glvbGhS/uNP58B8GKJNsfvgj2bCoXtOGUBNq0JPv/x4uS/ymGOx8L/Felz6SWXW
	5Q/zAWoYuto9YgYK48cw/bd0/De8oVdi3Gts=
X-Gm-Gg: ASbGnctLfa57mPab0oxUKQ2GQBo6bgFcEtuGsa1ipZ2lFDQ5DUvEDlawrkuVLf5KtOV
	WYNv8ZqU8DxQpvkpTuCgQP004JoR4Rmjkd47oPHoIrojxCNBsW84eYp7svxzrstcYTpRkZFASbg
	lv01y/xV9zwQRXsdBoaYT9erq0MVcf
X-Google-Smtp-Source: AGHT+IGNkdSZd0XaZ5qMQZ5W4GD3GaELmFvQP3psrIqbzZSWmlhQGOXTq74O3tnBVpgFKzH5SuVSR8oICqY9Ip+977w=
X-Received: by 2002:a2e:bccc:0:b0:30b:edd8:886 with SMTP id
 38308e7fff4ca-30f0bf1d3f8mr30684731fa.9.1744010855626; Mon, 07 Apr 2025
 00:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250307075610.2235124-1-martin.jansa@gmail.com> <182A7B773A5ECF09.13616@lists.yoctoproject.org>
In-Reply-To: <182A7B773A5ECF09.13616@lists.yoctoproject.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 7 Apr 2025 09:27:23 +0200
X-Gm-Features: ATxdqUG52y9SwqW59G5jqkD0Cv-cFXC91iOGGbtQFTOiSM_jSYdQ2gJffjSl2v4
Message-ID: <CA+chaQf4K+YGtwnxi6eKQ4vmUFeWWOZScNEfqcKKHa-7xNas_g@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][scarthgap][PATCH]
 tensorflow.inc: add write permission to 2 more directories
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Apr 2025 07:27:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1289

Hi,

in the last patch you've merged the author e-mail is OK now, but there
is still the notice from Wind River e-mail as well as second From:

meta-tensorflow $ git show -1 9e89de7 --pretty=3Dfuller
commit 9e89de7d5e4a7e58e3ffa4cf81a3b96f15ec5c30
Author:     Martin Jansa <martin.jansa@gmail.com>
AuthorDate: Wed Apr 2 18:00:08 2025 +0200
Commit:     Hongxu Jia <hongxu.jia@windriver.com>
CommitDate: Mon Apr 7 10:19:24 2025 +0800

    bazel: add whitespace around assignments

    CAUTION: This email comes from a non Wind River email account!
    Do not click links or open attachments unless you recognize the
sender and know the content is safe.

    From: Martin Jansa <martin.jansa@gmail.com>

    With:
....

Regards,

On Fri, Mar 7, 2025 at 10:32=E2=80=AFAM Martin Jansa via
lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
wrote:
>
> Hi,
>
> thank you for merging both, the way how you're applying the changes
> from e-mail still mangles the author and commit message.
>
> I've tried to add explicit From: in the e-mail body in hope to avoid
> "via lists.yoctoproject.org
> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>" but it didn't really
> help, instead the From: is still in the merged commit message together
> with "CAUTION: .." message from your e-mail configuration.
>
> meta-tensorflow $ git show -1 --pretty=3Dfuller origin/scarthgap | head -=
n 14
> commit c382865206fe925a02a1cdbdd856e16310bc9dbc
> Author:     Martin Jansa via lists.yoctoproject.org
> <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
> AuthorDate: Fri Mar 7 08:56:10 2025 +0100
> Commit:     Hongxu Jia <hongxu.jia@windriver.com>
> CommitDate: Fri Mar 7 16:16:58 2025 +0800
>
>     tensorflow.inc: add write permission to 2 more directories
>
>     CAUTION: This email comes from a non Wind River email account!
>     Do not click links or open attachments unless you recognize the
> sender and know the content is safe.
>
>     From: Martin Jansa <martin.jansa@gmail.com>
>
>     Missing write permission prevents the WORKDIR to be deleted, e.g.
> when recipe becomes unreachable
> ....
>
> On Fri, Mar 7, 2025 at 8:56=E2=80=AFAM <martin.jansa@gmail.com> wrote:
> >
> > From: Martin Jansa <martin.jansa@gmail.com>
> >
> > Missing write permission prevents the WORKDIR to be deleted, e.g. when =
recipe becames unreachable
> >
> > Removing 41 recipes from the core2-64 sysroot: 100% |##################=
###########################################################################=
###########################################################################=
##| Time: 0:00:21
> > Removing 35 recipes from the qemux86_64 sysroot: 100% |################=
###########################################################################=
###########################################################################=
##| Time: 0:00:00
> > ERROR: Execution of event handler 'sstate_eventhandler_reachablestamps'=
 failed                                                                    =
                                                                           =
  | ETA:  0:00:07
> > Traceback (most recent call last):
> >   File "/OE/build/oe-core/openembedded-core/meta/classes-global/sstate.=
bbclass", line 1293, in sstate_eventhandler_reachablestamps
> >     bb.utils.remove(workdir, recurse =3D True)
> >     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in remove
> >     subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
> >     ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
> >     raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-cor=
e/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero exit =
status 1.
> >
> > ERROR: Command execution failed: Traceback (most recent call last):
> >   File "/OE/build/oe-core/bitbake/lib/bb/command.py", line 123, in runA=
syncCommand
> >     self.cooker.updateCache()
> >     ~~~~~~~~~~~~~~~~~~~~~~~^^
> >   File "/OE/build/oe-core/bitbake/lib/bb/cooker.py", line 1646, in upda=
teCache
> >     bb.event.fire(event, self.databuilder.mcdata[mc])
> >     ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 224, in fire
> >     fire_class_handlers(event, d)
> >     ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
> >   File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 131, in fire_c=
lass_handlers
> >     execute_handler(name, handler, event, d)
> >     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 102, in execut=
e_handler
> >     ret =3D handler(event, d)
> >   File "/OE/build/oe-core/openembedded-core/meta/classes-global/sstate.=
bbclass", line 1293, in sstate_eventhandler_reachablestamps
> >     bb.utils.remove(workdir, recurse =3D True)
> >     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in remove
> >     subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
> >     ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
> >     raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-cor=
e/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero exit =
status 1.
> >
> > Summary: There were 2 ERROR messages, returning a non-zero exit code.
> >
> > OE qemux86-64@ /OE/build/oe-core $ find /OE/build/oe-core/tmp/work/x86_=
64-linux/tensorflow-native/2.17.0/
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/py=
thon
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/py=
thon/schema_py_srcs_no_include_all
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/py=
thon/schema_py_srcs_no_include_all/schema_generated.py
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/py=
thon/schema_py_srcs_no_include_all/__init__.py
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/p=
ip_package
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/p=
ip_package/wheel_house
> > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/=
output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/p=
ip_package/wheel_house/tensorflow-2.17.0-cp312-cp312-linux_x86_64.whl
> >
> > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > ---
> >  recipes-framework/tensorflow/tensorflow.inc | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-fram=
ework/tensorflow/tensorflow.inc
> > index e48808c..83e2d1a 100644
> > --- a/recipes-framework/tensorflow/tensorflow.inc
> > +++ b/recipes-framework/tensorflow/tensorflow.inc
> > @@ -61,6 +61,9 @@ export TS_DL_DIR
> >
> >  do_compile[network] =3D "1"
> >
> > +# Missing write permission prevents the WORKDIR to be deleted, e.g. wh=
en recipe becames unreachable
> >  do_compile:append() {
> >      chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-o=
ut/*/bin/tensorflow/lite/python/conversion_metadata_schema_py_srcs_no_inclu=
de_all || true
> > +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-o=
ut/*/bin/tensorflow/lite/python/schema_py_srcs_no_include_all || true
> > +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-o=
ut/*/bin/tensorflow/tools/pip_package/wheel_house || true
> >  }
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1164): https://lists.yoctoproject.org/g/yocto-patches=
/message/1164
> Mute This Topic: https://lists.yoctoproject.org/mt/111564223/3617156
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/1338883=
6/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

