Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E422CC19F32
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 09:32:47 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web11.7425.1741339957478612568
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 07 Mar 2025 01:32:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZUdSULuf;
 spf=pass (domain: gmail.com, ip: 209.85.167.50, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54965898051so1617610e87.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 07 Mar 2025 01:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741339955; x=1741944755; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOKkVq4fPl0OooiSmonsaddy0iQHZ15B01XIBzmKI4Y=;
        b=ZUdSULufYWV1PYx5m4DmaT9SIqLVf1jEeEdhY2swNVFsyXE3um2qf9srFtrK7AD756
         R+s9pEANjozzJwpeSJLPH/4zHN38oV/2QlJg8gfO6t943+hGv8asWNYh0zRj/ReXw3WO
         QtV6f6SmPdtoEkGVPXm67junL/iWdzcuXstP2g5OVulwIlnKL+1Mr1a3advdkUMOayY6
         BzqqtJI4LFBepK9fiBYI9W1GJoWp1a1otl0c/qWPBTBs+eC3FgvZlW6KkEwLbYU43MI+
         wcZ1TlvjAFRpnWZuN7xtIItlAyEDjBcwPmEuOkSLlf0tArOJGC0DoJ/VE3WLMSqwvm2J
         +f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339955; x=1741944755;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOKkVq4fPl0OooiSmonsaddy0iQHZ15B01XIBzmKI4Y=;
        b=SlrP2CszEEyXKNnZqSwys2yGrrZn4iNdlF0daSsJHwtz0c2YDi3DbT7/ySNtzi2WEP
         EdQWkN7K1me26BDWxlmC3bCS8da5lJRN/RUK7DUpEL7Ii+wDax+LtQkRIK0hTRBVYn44
         LAuPkcuzUjsvjZEp596tm+J7914qkfPXIa2gzpv7iYS3tnX0nixB+ocjDSmukU3X6cMZ
         s8F+Nm8ea3G9CwzkJ/bVRjXLrqK3u7go2gUy+a9SwmQ3VOCe4FAPKuqt/EuOawa9Qdxz
         b+Xav0niqLYtmMQ3MyKsN5hFi42XuH5VAKroa0HgPFIU59Wh/Z5Uo0Ejr1zZEKvXAwmI
         4fpQ==
X-Gm-Message-State: AOJu0Yx/qg2cWyTTo+mkAosOQxn0IRXxZm4cly1r0eCRco1+lniyZgBz
	mQZUYJncH6EsZSkGk67cvah66aSiPKeZj++HtO28ltWaTQbTwKsKX2TLaneZvUjdkJrZr8inlUK
	SsfD1OOcEilhw6dMUKh3YTshRoQIpF3Ze
X-Gm-Gg: ASbGncv4KsLRWqCOA6/vDgQcFvkgixn+FT8H4qCfP8cXHcOkmgufLnN9Gsg6H1AWfYF
	jrje2LB+1Jo2KEcE0mTZhvfe2XqQURIp8So6CsNo+6y/ggSWqI8wL6i0aqgQyW7hAeddZzFLlrf
	KkPNnvZPpqdlHzDOq6Ch55G//WXFmy
X-Google-Smtp-Source: AGHT+IG5Lb4ozCHXHBOS5Kpun+MAbT2XjnOsYgA3wK302zzgZDBluy3xjpnvP8dfKBQ257eu8w9D0hSRyjhI/9RACPA=
X-Received: by 2002:a05:6512:398a:b0:545:4cb:b25d with SMTP id
 2adb3069b0e04-54990e5d965mr770688e87.13.1741339954613; Fri, 07 Mar 2025
 01:32:34 -0800 (PST)
MIME-Version: 1.0
References: <20250307075610.2235124-1-martin.jansa@gmail.com>
In-Reply-To: <20250307075610.2235124-1-martin.jansa@gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Fri, 7 Mar 2025 10:32:23 +0100
X-Gm-Features: AQ5f1Jq5iGTvW6BBGptii4f_hEjQ_M0w50CTGIYpcGW0MUquSCvt9hpF7hNH5QE
Message-ID: <CA+chaQcN2LjK4NSVWCVWHPsX5++d-n6YoLHXy0=Y+dXUeeYb9A@mail.gmail.com>
Subject: Re: [meta-tensorflow][scarthgap][PATCH] tensorflow.inc: add write
 permission to 2 more directories
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 07 Mar 2025 09:32:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1164

Hi,

thank you for merging both, the way how you're applying the changes
from e-mail still mangles the author and commit message.

I've tried to add explicit From: in the e-mail body in hope to avoid
"via lists.yoctoproject.org
<martin.jansa=3Dgmail.com@lists.yoctoproject.org>" but it didn't really
help, instead the From: is still in the merged commit message together
with "CAUTION: .." message from your e-mail configuration.

meta-tensorflow $ git show -1 --pretty=3Dfuller origin/scarthgap | head -n =
14
commit c382865206fe925a02a1cdbdd856e16310bc9dbc
Author:     Martin Jansa via lists.yoctoproject.org
<martin.jansa=3Dgmail.com@lists.yoctoproject.org>
AuthorDate: Fri Mar 7 08:56:10 2025 +0100
Commit:     Hongxu Jia <hongxu.jia@windriver.com>
CommitDate: Fri Mar 7 16:16:58 2025 +0800

    tensorflow.inc: add write permission to 2 more directories

    CAUTION: This email comes from a non Wind River email account!
    Do not click links or open attachments unless you recognize the
sender and know the content is safe.

    From: Martin Jansa <martin.jansa@gmail.com>

    Missing write permission prevents the WORKDIR to be deleted, e.g.
when recipe becomes unreachable
....

On Fri, Mar 7, 2025 at 8:56=E2=80=AFAM <martin.jansa@gmail.com> wrote:
>
> From: Martin Jansa <martin.jansa@gmail.com>
>
> Missing write permission prevents the WORKDIR to be deleted, e.g. when re=
cipe becames unreachable
>
> Removing 41 recipes from the core2-64 sysroot: 100% |####################=
###########################################################################=
###########################################################################=
| Time: 0:00:21
> Removing 35 recipes from the qemux86_64 sysroot: 100% |##################=
###########################################################################=
###########################################################################=
| Time: 0:00:00
> ERROR: Execution of event handler 'sstate_eventhandler_reachablestamps' f=
ailed                                                                      =
                                                                           =
| ETA:  0:00:07
> Traceback (most recent call last):
>   File "/OE/build/oe-core/openembedded-core/meta/classes-global/sstate.bb=
class", line 1293, in sstate_eventhandler_reachablestamps
>     bb.utils.remove(workdir, recurse =3D True)
>     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in remove
>     subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
>     ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-core/=
tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero exit st=
atus 1.
>
> ERROR: Command execution failed: Traceback (most recent call last):
>   File "/OE/build/oe-core/bitbake/lib/bb/command.py", line 123, in runAsy=
ncCommand
>     self.cooker.updateCache()
>     ~~~~~~~~~~~~~~~~~~~~~~~^^
>   File "/OE/build/oe-core/bitbake/lib/bb/cooker.py", line 1646, in update=
Cache
>     bb.event.fire(event, self.databuilder.mcdata[mc])
>     ~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 224, in fire
>     fire_class_handlers(event, d)
>     ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^
>   File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 131, in fire_cla=
ss_handlers
>     execute_handler(name, handler, event, d)
>     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/OE/build/oe-core/bitbake/lib/bb/event.py", line 102, in execute_=
handler
>     ret =3D handler(event, d)
>   File "/OE/build/oe-core/openembedded-core/meta/classes-global/sstate.bb=
class", line 1293, in sstate_eventhandler_reachablestamps
>     bb.utils.remove(workdir, recurse =3D True)
>     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/OE/build/oe-core/bitbake/lib/bb/utils.py", line 751, in remove
>     subprocess.check_call(cmd + ['rm', '-rf'] + glob.glob(path))
>     ~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/lib/python3.13/subprocess.py", line 421, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['rm', '-rf', '/OE/build/oe-core/=
tmp/work/x86_64-linux/tensorflow-native/2.17.0']' returned non-zero exit st=
atus 1.
>
> Summary: There were 2 ERROR messages, returning a non-zero exit code.
>
> OE qemux86-64@ /OE/build/oe-core $ find /OE/build/oe-core/tmp/work/x86_64=
-linux/tensorflow-native/2.17.0/
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/pyth=
on
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/pyth=
on/schema_py_srcs_no_include_all
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/pyth=
on/schema_py_srcs_no_include_all/schema_generated.py
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/lite/pyth=
on/schema_py_srcs_no_include_all/__init__.py
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/pip=
_package
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/pip=
_package/wheel_house
> /OE/build/oe-core/tmp/work/x86_64-linux/tensorflow-native/2.17.0/bazel/ou=
tput_base/execroot/org_tensorflow/bazel-out/k8-opt/bin/tensorflow/tools/pip=
_package/wheel_house/tensorflow-2.17.0-cp312-cp312-linux_x86_64.whl
>
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>  recipes-framework/tensorflow/tensorflow.inc | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/recipes-framework/tensorflow/tensorflow.inc b/recipes-framew=
ork/tensorflow/tensorflow.inc
> index e48808c..83e2d1a 100644
> --- a/recipes-framework/tensorflow/tensorflow.inc
> +++ b/recipes-framework/tensorflow/tensorflow.inc
> @@ -61,6 +61,9 @@ export TS_DL_DIR
>
>  do_compile[network] =3D "1"
>
> +# Missing write permission prevents the WORKDIR to be deleted, e.g. when=
 recipe becames unreachable
>  do_compile:append() {
>      chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-out=
/*/bin/tensorflow/lite/python/conversion_metadata_schema_py_srcs_no_include=
_all || true
> +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-out=
/*/bin/tensorflow/lite/python/schema_py_srcs_no_include_all || true
> +    chmod a+w ${BAZEL_DIR}/output_base/execroot/org_tensorflow/bazel-out=
/*/bin/tensorflow/tools/pip_package/wheel_house || true
>  }

