Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD39CC35FFC
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:07:22 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
 by mx.groups.io with SMTP id smtpd.web11.66357.1742911639128047397
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 25 Mar 2025 07:07:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Vi40GwKE;
 spf=pass (domain: gmail.com, ip: 209.85.167.51, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5497590ffbbso6228845e87.1
        for <yocto-patches@lists.yoctoproject.org>; Tue, 25 Mar 2025 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742911637; x=1743516437; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhLn/Cqms9nd8Z+/LMEMNSJLsyVxvpOKB2QxtuIPUHI=;
        b=Vi40GwKEONkLgbRrDTFOUit4vnjl/4nyd1cNK8WtZgbflze26tOLejWTVUpmLYozhZ
         xsxTmpClFwsBslPnjpppCAeXATJ8tOqCYvSyGN+5okz2cfEaLImsEAiZnZBwoh2EI0UD
         2E8bB3BSvqESfjrqMNgzEP5WPd/7ioO0wFzWOzUbJ463S7YcIue8yBgB4DA9XtQ0PKrz
         u99ULdKfqes6cyuF6Iv+RhHD5XtRER0IHQeZQ6YGhS7fEYSvydziu6HCnw7WLDRr1rGG
         3jVvA+gZqfBg8KtbRj2lat3t9kqtDkieun6FzDRRUzPcDuChQjN60dJcL6ShpFhYfAiX
         SYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911637; x=1743516437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhLn/Cqms9nd8Z+/LMEMNSJLsyVxvpOKB2QxtuIPUHI=;
        b=fwXPZrW3dIPlH1Uh04i75YL06BjJQQWZcSxHxDIUUO7r4vgTE4NSdf4hMX+oBQJEtr
         4W4bbXgAJNkLxR8PreCtCfqbghC4NS/Ss0wxifhjC/0G6yU9JnzEqvqQhhwz5grWqJ7K
         fB8RaZcOgnj/hClaDrquR6Vxb9jEeIQ+KjBKyT2PBa4lay5NyZhCMuuby1ncOKytZp8I
         wdHqfb7d+lpYMuW6gzipCAQ3dKAy8pJUvFUdCWwj5mdH8V0acX5N7GTgx0SrlUzHzE4R
         pHeofOZVCdOWKC3VdJB4H9q32gZ8vgffGOM0eU88hTq845hVcW+g8SFG907wutq17NqG
         Yj0w==
X-Gm-Message-State: AOJu0Yy5Cz3AJkrk52UqUVoXLQwkjdyesBNeSscRiMUHKYPCATxLxAU9
	TXNPKXlOnVQkmU66L9aGZPEGeEVVgWAGqqb64AcKkEEvdWlVLUeN9R+r2lYr1+3xrdzuOznYWDk
	bu3OFRx1TTDZQZWDRNFjq3a7HFKv/uoyGlsA=
X-Gm-Gg: ASbGnctK/m0LKYk2ZkuoZo5g6ABo36l5Up7Ds7szCLhRRIm4f94IgymV0OgjpeCu8n1
	ISi+kftGY5TJkiRlowrnxyJvJx1K+yw4fVJ7CgB+wcLnLOzUcpMt2ERhOnlvD+rbjFbcQc6z0Sc
	3DiRgI13nuLdiszEwa9dC/mEzr+ry6
X-Google-Smtp-Source: AGHT+IEbCqxRZp9qsnrjWSeSon9T8gb0KlMNlvasBkFhlN2bBFFfqclV6M7/+hnn0MWv8uf4tSl1BNoQ072aqyriUEo=
X-Received: by 2002:a05:6512:3a91:b0:549:4f0e:8e28 with SMTP id
 2adb3069b0e04-54ad649142fmr7149045e87.15.1742911636446; Tue, 25 Mar 2025
 07:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250307075610.2235124-1-martin.jansa@gmail.com>
 <182A7B773A5ECF09.13616@lists.yoctoproject.org> <CA+chaQetojj=EwWEA2B+jmL3kk8Ap0FAPv4N0n2NLY-VQ-FRCQ@mail.gmail.com>
 <PH7PR11MB7608B1BFFCA15F5A02EE4FA394A42@PH7PR11MB7608.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7608B1BFFCA15F5A02EE4FA394A42@PH7PR11MB7608.namprd11.prod.outlook.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 25 Mar 2025 15:07:02 +0100
X-Gm-Features: AQ5f1JonJV63MjHOOs8mzXS1au7cFLuKJDA2MwNzym1DHclPs-LzfmGbHCRsAp8
Message-ID: <CA+chaQcs6ut65AGwi5_oWpGe-zNpE0tJCH2HRPOT_AXz1TUQ7Q@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-tensorflow][scarthgap][PATCH]
 tensorflow.inc: add write permission to 2 more directories
To: "Jia, Hongxu" <Hongxu.Jia@windriver.com>
Cc: "yocto-patches@lists.yoctoproject.org" <yocto-patches@lists.yoctoproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 25 Mar 2025 14:07:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1249

yes, that fixes the parsing.

To build it with python-3.13 in walnascar you can backport
https://github.com/tensorflow/tensorflow/pull/82768 , tensorflow-lite
builds fine with it.

To build with gcc-15 it needs
https://github.com/abseil/abseil-cpp/commit/809e5de7b92950849289236a5a09e9c=
b4f32c7b9
applied in absl from third_party/absl/workspace.bzl

Cheers,

On Mon, Mar 24, 2025 at 3:37=E2=80=AFPM Jia, Hongxu <Hongxu.Jia@windriver.c=
om> wrote:
>
> Sorry for the error, I've corrected for styhead branch,
>
> https://git.yoctoproject.org/meta-tensorflow/log/?h=3Dstyhead
>
> would you please retry it
>
> //Hongxu
>
> ________________________________
> From: Martin Jansa <martin.jansa@gmail.com>
> Sent: Monday, March 24, 2025 6:13 PM
> To: yocto-patches@lists.yoctoproject.org <yocto-patches@lists.yoctoprojec=
t.org>; Jia, Hongxu <Hongxu.Jia@windriver.com>
> Subject: Re: [yocto-patches] [meta-tensorflow][scarthgap][PATCH] tensorfl=
ow.inc: add write permission to 2 more directories
>
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d know the content is safe.
>
> Hi Hongxu,
>
> I see you've created styhead branch, but the python3-numpy added in:
> https://git.yoctoproject.org/meta-tensorflow/commit/?h=3Dstyhead&id=3D256=
5836457994a84776e0d02356ead3bbba093de
> doesn't even parse with styhead because of:
> meta-tensorflow/recipes-devtools/python/python3-numpy_2.1.3.bb:21:
> Could not inherit file classes/cython.bbclass
>
> Please check that.
>
> Cheers,
>
> On Fri, Mar 7, 2025 at 10:32=E2=80=AFAM Martin Jansa via
> lists.yoctoproject.org <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
> wrote:
> >
> > Hi,
> >
> > thank you for merging both, the way how you're applying the changes
> > from e-mail still mangles the author and commit message.
> >
> > I've tried to add explicit From: in the e-mail body in hope to avoid
> > "via lists.yoctoproject.org
> > <martin.jansa=3Dgmail.com@lists.yoctoproject.org>" but it didn't really
> > help, instead the From: is still in the merged commit message together
> > with "CAUTION: .." message from your e-mail configuration.
> >
> > meta-tensorflow $ git show -1 --pretty=3Dfuller origin/scarthgap | head=
 -n 14
> > commit c382865206fe925a02a1cdbdd856e16310bc9dbc
> > Author:     Martin Jansa via lists.yoctoproject.org
> > <martin.jansa=3Dgmail.com@lists.yoctoproject.org>
> > AuthorDate: Fri Mar 7 08:56:10 2025 +0100
> > Commit:     Hongxu Jia <hongxu.jia@windriver.com>
> > CommitDate: Fri Mar 7 16:16:58 2025 +0800
> >
> >     tensorflow.inc: add write permission to 2 more directories
> >
> >     CAUTION: This email comes from a non Wind River email account!
> >     Do not click links or open attachments unless you recognize the
> > sender and know the content is safe.
> >
> >     From: Martin Jansa <martin.jansa@gmail.com>
> >
> >     Missing write permission prevents the WORKDIR to be deleted, e.g.
> > when recipe becomes unreachable
> > ....
> >
> > On Fri, Mar 7, 2025 at 8:56=E2=80=AFAM <martin.jansa@gmail.com> wrote:
> > >
> > > From: Martin Jansa <martin.jansa@gmail.com>
> > >
> > > Missing write permission prevents the WORKDIR to be deleted, e.g. whe=
n recipe becames unreachable
> > >
> > > Removing 41 recipes from the core2-64 sysroot: 100% |################=
###########################################################################=
###########################################################################=
####| Time: 0:00:21
> > > Removing 35 recipes from the qemux86_64 sysroot: 100% |##############=
###########################################################################=
###########################################################################=
####| Time: 0:00:00
> > > ERROR: Execution of event handler 'sstate_eventhandler_reachablestamp=
s' failed                                                                  =
                                                                           =
    | ETA:  0:00:07
> > > Traceback (most recent call last):
> > >   File "/OE/build/oe-core/openembedded-core/meta/classes-global/sstat=
e.bbclass", line 1293, in sstate_eventhandler_reachablestamps
> > >     bb.utils.remove(workdir, recurse =3D True)
> > >     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in remo=
ve
> > >     subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
> > >     ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
> > >     raise CalledProcessError(retcode, cmd)
> > > subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-c=
ore/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero exi=
t status 1.
> > >
> > > ERROR: Command execution failed: Traceback (most recent call last):
> > >   File "/OE/build/oe-core/bitbake/lib/bb/command.py", line 123, in ru=
nAsyncCommand
> > >     self.cooker.updateCache()
> > >     ~~~~~~~~~~~~~~~~~~~~~~~^^
> > >   File "/OE/build/oe-core/bitbake/lib/bb/cooker.py", line 1646, in up=
dateCache
> > >     bb.event.fire(event, self.databuilder.mcdata[mc])
> > >     ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 224, in fire
> > >     fire_class_handlers(event, d)
> > >     ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
> > >   File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 131, in fire=
_class_handlers
> > >     execute_handler(name, handler, event, d)
> > >     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 102, in exec=
ute_handler
> > >     ret =3D handler(event, d)
> > >   File "/OE/build/oe-core/openembedded-core/meta/classes-global/sstat=
e.bbclass", line 1293, in sstate_eventhandler_reachablestamps
> > >     bb.utils.remove(workdir, recurse =3D True)
> > >     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in remo=
ve
> > >     subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
> > >     ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > >   File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
> > >     raise CalledProcessError(retcode, cmd)
> > > subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-c=
ore/tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero exi=
t status 1.
> > >
> > > Summary: There were 2 ERROR messages, returning a non-zero exit code.
> > >
> > > OE qemux86-64@ /OE/build/oe-core $ find /OE/build/oe-core/tmp/work/x8=
6_64-linux/tensorflow-native/2.17.0/
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/=
python
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/=
python/schema_py_srcs_no_include_all
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/=
python/schema_py_srcs_no_include_all/schema_generated.py
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/=
python/schema_py_srcs_no_include_all/__init__.py
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools=
/pip_package
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools=
/pip_package/wheel_house
> > > /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/baze=
l/output_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools=
/pip_package/wheel_house/tensorflow-2.17.0-cp312-cp312-linux_x86_64.whl
> > >
> > > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > > ---
> > >  recipes-framework/tensorflow/tensorflow.inc | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-fr=
amework/tensorflow/tensorflow.inc
> > > index e48808c..83e2d1a 100644
> > > --- a/recipes-framework/tensorflow/tensorflow.inc
> > > +++ b/recipes-framework/tensorflow/tensorflow.inc
> > > @@ -61,6 +61,9 @@ export TS_DL_DIR
> > >
> > >  do_compile[network] =3D "1"
> > >
> > > +# Missing write permission prevents the WORKDIR to be deleted, e.g. =
when recipe becames unreachable
> > >  do_compile:append() {
> > >      chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel=
-out/*/bin/tensorflow/lite/python/conversion_metadata_schema_py_srcs_no_inc=
lude_all || true
> > > +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel=
-out/*/bin/tensorflow/lite/python/schema_py_srcs_no_include_all || true
> > > +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel=
-out/*/bin/tensorflow/tools/pip_package/wheel_house || true
> > >  }
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#1164): https://lists.yoctoproject.org/g/yocto-patch=
es/message/1164
> > Mute This Topic: https://lists.yoctoproject.org/mt/111564223/3617156
> > Group Owner: yocto-patches+owner@lists.yoctoproject.org
> > Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13388=
836/3617156/66960823/xyzzy [martin.jansa@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >
> >

