Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF72AC36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 10:13:41 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web10.35989.1742811220192459680
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Mar 2025 03:13:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iudBaVEN;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30c05fd126cso38062981fa.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Mar 2025 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742811218; x=1743416018; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGo9SwPFeQr90VQR4S7J+y7QsZ6EF9PJF89QJAdxzu8=;
        b=iudBaVENiyWt/GZYouiUtmM/QrF30sUMh+W3+s+Ryqyl2EZxGOgi6nc2MmRdHPNChz
         m+AmTVg50BZ4Nv4uc7vqP7fckOy4WzfpcK7/1Uc0UpMpgqD6GEbYJDJC7iFfUFmCBIBH
         KVEQYefYjw8n4m5eUBn6+vjIExolPdQ9rj0Z9Yj84A537WFHNWTYffQw0erG93hcGK5d
         lPEUZbtw55CEI+u7BMCC8gFjN4Zy+1sIG2Mxe8WYXsRqy9QgM1fsn5NAxnvBs4y7/r2X
         134Cezd+gDy9O1D2mKgLMLBO0bw71Fwi0RMYY18dMW343mfdT+mfQvDHga5wCyV8+0R6
         Zeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742811218; x=1743416018;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGo9SwPFeQr90VQR4S7J+y7QsZ6EF9PJF89QJAdxzu8=;
        b=TcWObxu/FhxQJ9BdqvcK4TM170IlenwKlMmI2nx8jr6vRDzv3TLUu8T+XPz6gYmuXQ
         aaHBrUdWjX0LkU3CqL9DHARtkoZ/y1p5tJ0bTm549bL039wv2kz6O9k78So4/9sLIMp7
         1w/t9SQbxOnJ7yhOrYYc5OqPZ7Y2aMdbKs8Fz/0HtV1ZiV6j/7XygJCa68jf4ATdZuIm
         GM7bE5D6AA/taeFGL3zdl9CZsxHol5tW9W2j2Q4V/6JbZyrE6x83yx4l1oHtFKOAzLSR
         dB1KsM7ckWHHDs/MSTX/VWaADZ27N3qxaTBxik2KyS1A8xj+e5YKG/MWCFQso0Pj8yxG
         HR/Q==
X-Gm-Message-State: AOJu0YxDROqrmqwTZqKkWXmCWHKiOejMuYx2XhZMSJUORhKdpwvHMKdu
	FXrbtQa0ssQp61tVS7scxVkVam7WUiZYqQNi2fooXRsWtUPh04yJv0uRO4NXlGeHfAJ4uHQ+pTH
	o4drNKeVBnfEtQj7EWXiWIQftkInRUTBH1ZY=
X-Gm-Gg: ASbGncvSjzyNZT/JWUy1EUsB4Znkzc9uaL5ZQlBaeDAG9+0B7P4uoqVLUGNfcWjJC1T
	qNQgY8qlaBQQP++TbIEGsiyulAMX1rqm9TGYoFFyFcW93YuPfBihC9l9MtWR7jjcjnnRuQyHFz2
	FhLdNEYsfKE0uVVRrTCMWFUgHYY7vu
X-Google-Smtp-Source: AGHT+IHFQPlUkWyo9+UC75F4lorWJF8AkNAUJKvaPsyQrq6sN7xC0PfSExvRmVdLVzra12Bsn0VJfw2mDpvKg/3xsv0=
X-Received: by 2002:a2e:6a05:0:b0:308:ec25:9004 with SMTP id
 38308e7fff4ca-30d7e2bb98dmr44525261fa.35.1742811217665; Mon, 24 Mar 2025
 03:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250307075610.2235124-1-martin.jansa@gmail.com> <182A7B773A5ECF09.13616@lists.yoctoproject.org>
In-Reply-To: <182A7B773A5ECF09.13616@lists.yoctoproject.org>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 24 Mar 2025 11:13:25 +0100
X-Gm-Features: AQ5f1JrUsYZ-nmW4t3Pk1YBsOcwCHqJfh7v1K5-3L05SrJgyhO8GZQ--lo6G1rQ
Message-ID: <CA+chaQetojj=EwWEA2B+jmL3kk8Ap0FAPv4N0n2NLY-VQ-FRCQ@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][scarthgap][PATCH]
 tensorflow.inc: add write permission to 2 more directories
To: yocto-patches@lists.yoctoproject.org, 
	Hongxu Jia <hongxu.jia@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Mar 2025 10:13:41 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1244

Hi Hongxu,

I see you've created styhead branch, but the python3-numpy added in:
https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dstyhead&id=3D25658=
36457994a84776e0d02356ead3bbba093de
doesn't even parse with styhead because of:
meta-tensorflow/recipes-devtools/python/python3-numpy_2.1.3.bb:21:
Could not inherit file classes/cython.bbclass

Please check that.

Cheers,

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

