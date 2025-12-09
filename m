Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7512DD3B99E
	for <webhook@archiver.kernel.org>; Tue,  9 Dec 2025 22:06:43 +0000 (UTC)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2872.1765317999937948263
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Dec 2025 14:06:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FXoL/5wK;
 spf=pass (domain: gmail.com, ip: 209.85.167.41, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-594330147efso6760978e87.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 14:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765317998; x=1765922798; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4jafSYr4nzRSChP0EjPn0zLTPLV2DQUdXnuZ2qrNBM=;
        b=FXoL/5wKD3t2gn8UGV1+FMB/PCvlGdVFBPBWbjITPXkS/MVEJAlmRTTEnLrEDsqIKF
         s7dVcfxpLyFyUUD/xTmi7KkK42Lx4W/gfWBO+fZ43pfCDBzo2iGokgtxecLN0s8qgKMP
         osmcJ1xr3dlf/E4qqgX1fDhM894EusQwxUz+zYZxNiayzszmUBa1e79zjBKVzlSm4lOC
         kFDws2/MBDYdV/JN5hFaUz9krJ1iNcU/bdiY6STgJMzOK6bzcoXQEximikM9V1S0ekFu
         R6mJ3rweOMSP9+Y6sUouWCvNb+EZbu1C1yRjOC12gc20NrwxpUEv0csa85xchcVbkG4O
         Ygbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765317998; x=1765922798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4jafSYr4nzRSChP0EjPn0zLTPLV2DQUdXnuZ2qrNBM=;
        b=FUd2ejiZKCPF7Rwazpl/dPDQUGq8Lll83xWE8F+EuCUWxCYvRvpPwDlTz+LIED144Y
         68Gea/bJgGFCqmd1EDYjP62weA1FWrEfBABX8tSqjDO3h8Zy8l8icIngFQER4k41VUUn
         WbGCKQZ1VF3u6Fm/6AoJdDaqYaa3MVFPycf7EUFC1R0Q5MYLiC4ypt3ZIVRbV/4R5wnJ
         sjXqozPV8d4zqM5BlQYTOZJqw2Y5FrHwpmO9I+UgjQcQoi/IwQnn5J7uUMjF3yGmetDx
         7b006c7wL1XjxWAZyjnTj1ILE9g5VpN5X5/6i7KpycN9Gga/D+WIa2/Zq9zMPnfQkwBZ
         DyYQ==
X-Gm-Message-State: AOJu0YwyeqTnlYYUhMQdhp0oq5AlZzifTW2BMTjotiRfAftETBItGnLs
	6u+LzgfT1tNw9BqBTNYyUs/C20WeAvX6OcCwiXjAJubUQ1sW3tK1q9ILNPf5jLj8RHNdcCLFpAz
	UU62Hnh9qy3U/QCpX5pWa28VwtXgnIp8=
X-Gm-Gg: ASbGnctGG+ZkSDm2upKZNITWWa4j7Xc2iUjXfm1F9oftKTMrqTau1AoRllFbBXnQsQi
	LIqoHd75dE/sWi1KCS3xIZrKVjYfw54EQyAi5QgRzy0VO9iTVfpMkZK6Pue3IC58dDeY+1CAOtz
	ILsHx0YcAxdQ6tAwDPIw3B1LVa6U1dvLdnvRQm7ZiYbdr7OYxk+UgXS76m9VMpUTZl7jISQpuM3
	GX64KLJgU5zXV2sey7Hz4mcY9BfrswvGuGaGLdqCnGQSapmWi2TPzZHVgxyLhlDS7ePkN9OPuWy
	mWrO
X-Google-Smtp-Source: AGHT+IF08g6FUGYmCc5LdZINbK8OHYCf0E7rxghayghzSZTiP7n8mmsz0s9E1ot7F2HcxzgDMyyTz6y1gqWeyWNFtPc=
X-Received: by 2002:a05:6512:3f28:b0:595:7f2e:ddfa with SMTP id
 2adb3069b0e04-598ee4dae49mr184588e87.3.1765317997689; Tue, 09 Dec 2025
 14:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20251208223118.374387-2-t.f.g.geelen@gmail.com>
 <CAJo0Az6wHkTjxxMYTnwbdxhq0VSnnXvDwtXuuRcd=5vy2NQ0Rg@mail.gmail.com> <CANNYZj9O_3P6oUo5b9KnU=dDKJDy3=xdmnDsXPQL=jBc0T07TA@mail.gmail.com>
In-Reply-To: <CANNYZj9O_3P6oUo5b9KnU=dDKJDy3=xdmnDsXPQL=jBc0T07TA@mail.gmail.com>
From: Tom Geelen <t.f.g.geelen@gmail.com>
Date: Tue, 9 Dec 2025 23:06:28 +0100
X-Gm-Features: AQt7F2qShHmT1OrXb3gvQLkXTYkp62Ah_pWa8xdmbf7zKeCziSs5svvpjzWlbSs
Message-ID: <CAJo0Az4FAesnZFA5Nx3fsLa_TDwbjRBPnb9s7Hz-TMN+FRHsWg@mail.gmail.com>
Subject: Re: [auh][PATCH 2/2] testimage: adjust qmp detection for testimage
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Dec 2025 22:06:43 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2757

Hi Alex,

Certainly, here is an example which triggers the problem on my end.

My upgrade-helper.conf file:

[maintainer_override]

[settings]
from=3Dt.f.g.geelen@gmail.com
maintainers_whitelist=3Dt.f.g.geelen@gmail.com tim.orling@konsulko.com
machines=3Dqemux86-64
commit_revert_policy=3Dfailed_to_build
testimage=3Dyes
testimage_name=3Dcore-image-test

The core-image-test which is referenced is here:
https://github.com/Gerry546/meta-sanctum/blob/main/meta-sanctum/recipes-ima=
ges/images/core-image-test.bb
It is a minimal image to run ptest on a qemu target.

I noticed this issue when trying to upgrade python3-attrs currently as
I need the latest version. You will need to remove this from the
recipe though as the recipe itself fails to compile after the upgrade
as this file is no longer needed. I use master on all layers

do_install_ptest:append() {
    install ${S}/conftest.py ${D}${PTEST_PATH}/
}

This is the output I see in my testimage.log

Summary: 1 task failed:
  /home/tom/projects/meta-sanctum/build-homeassistant/layers/../../meta-san=
ctum/recipes-images/images/core-image-test.bb:do_testimage
    log: /home/tom/projects/meta-sanctum/build-homeassistant/build/tmp/work=
/qemux86_64-oe-linux/core-image-test/1.0/temp/log.do_testimage.624190
Summary: There were 2 ERROR messages, returning a non-zero exit code.
ERROR: core-image-test-1.0-r0 do_testimage: qemurunner: qmp module
missing, please ensure it's installed in
/home/tom/projects/meta-sanctum/build-homeassistant/build/upgrade-helper/20=
251209222910/recipe-sysroot-native/usr/lib/qemu-python
(No module named 'qmp')
ERROR: core-image-test-1.0-r0 do_testimage: Error executing a python
function in exec_func_python() autogenerated:

The stack trace of python calls that resulted in this exception/failure was=
:
File: 'exec_func_python() autogenerated', lineno: 2, function: <module>
     0001:
 *** 0002:do_testimage(d)
     0003:
File: '/home/tom/projects/meta-sanctum/build-homeassistant/layers/../../sou=
rces/openembedded-core/meta/classes-recipe/testimage.bbclass',
lineno: 124, function: do_testimage
     0120:    dump-guest-memory {"paging":false,"protocol":"file:%s.img"}
     0121:}
     0122:
     0123:python do_testimage() {
 *** 0124:    testimage_main(d)
     0125:}
     0126:
     0127:addtask testimage
     0128:do_testimage[nostamp] =3D "1"
File: '/home/tom/projects/meta-sanctum/build-homeassistant/layers/../../sou=
rces/openembedded-core/meta/classes-recipe/testimage.bbclass',
lineno: 376, function: testimage_main
     0372:    orig_sigterm_handler =3D signal.signal(signal.SIGTERM,
sigterm_exception)
     0373:    try:
     0374:        # We need to check if runqemu ends unexpectedly
     0375:        # or if the worker send us a SIGTERM
 *** 0376:        tc.target.start(params=3Dd.getVar("TEST_QEMUPARAMS"),
runqemuparams=3Dd.getVar("TEST_RUNQEMUPARAMS"))
     0377:        import threading
     0378:        try:
     0379:
threading.Timer(int(d.getVar("TEST_OVERALL_TIMEOUT")),
handle_test_timeout, (int(d.getVar("TEST_OVERALL_TIMEOUT")),)).start()
     0380:        except ValueError:
File: '/home/tom/projects/meta-sanctum/build-homeassistant/layers/../../sou=
rces/openembedded-core/meta/lib/oeqa/core/target/qemu.py',
lineno: 91, function: start
     0087:            except (subprocess.CalledProcessError,
subprocess.TimeoutExpired, FileNotFoundError) as err:
     0088:                msg +=3D "Error running command: %s\n%s\n" %
(blcmd, err)
     0089:            msg +=3D "\n\n=3D=3D=3D=3D=3D end: snippet =3D=3D=3D=
=3D=3D\n"
     0090:
 *** 0091:            raise RuntimeError("FAILED to start qemu - check
the task log and the boot log %s" % (msg))
     0092:
     0093:    def stop(self):
     0094:        self.runner.stop()
Exception: RuntimeError: FAILED to start qemu - check the task log and
the boot log

 And this is the log of the upgrade-helper:

Reconnecting to bitbake server...
Retrying server connection (#1)... (22:29:11.267662)
Reconnecting to bitbake server...
Retrying server connection (#1)... (22:29:11.267662)
Starting bitbake server...
 ########### The list of recipes to be upgraded #############
 , python3-attrs, 25.3.0, 25.4.0, Tim Orling <tim.orling@konsulko.com>, N/A
 ############################################################
 Building gcc runtimes ...
  building gcc runtime for qemux86-64
 ATTEMPT PACKAGE GROUP 1/1
 python3-attrs: Upgrading to 25.4.0
 python3-attrs: Loading environment ...
 python3-attrs: Running 'devtool upgrade' ...
 python3-attrs: Running 'devtool finish' ...
 python3-attrs: compiling upgraded version for qemux86-64 ...
 python3-attrs: Upgrade SUCCESSFUL! Please test!
 python3-attrs: Auto commit changes ...
 python3-attrs: Save patch in directory:
/home/tom/projects/meta-sanctum/build-homeassistant/build/upgrade-helper/20=
251209222910/all/python3-attrs.
  Testing image for qemux86-64 ...
 Checking if package python3-attrs has ptests...
  ...yes
 Installing additional packages to the image: python3-attrs python3-attrs-p=
test
   building core-image-test for qemux86-64 ...
   building the testimage failed! Collecting logs...
 All done! Testimage/ptest/qemu logs are collected to
/home/tom/projects/meta-sanctum/build-homeassistant/build/upgrade-helper/20=
251209222910/testimage-logs
 Generating work tarball in
/home/tom/projects/meta-sanctum/build-homeassistant/build/upgrade-helper/20=
251209222910.tar.gz
...
 Recipe upgrade statistics:

    * Succeeded: 1
        python3-attrs, 25.4.0, Tim Orling <tim.orling@konsulko.com>

    TOTAL: attempted=3D1 succeeded=3D1(100.00%) failed=3D0(0.00%)

Recipe upgrade statistics per Maintainer:

    Tim Orling <tim.orling: attempted=3D1 succeeded=3D1(100.00%) failed=3D0=
(0.00%)

Let me know whenever you are planning on doing an AUH upgrade.. I use
AUH actually quite heavily for my work in meta-homeassistant as it
saves me a tremendous amount of time and I would love to help with
this tool. It has a lot of potential.

Regards,

Tom



On Tue, Dec 9, 2025 at 10:02=E2=80=AFAM Alexander Kanavin
<alex.kanavin@gmail.com> wrote:
>
> On Mon, 8 Dec 2025 at 23:40, Tom Geelen <t.f.g.geelen@gmail.com> wrote:
> > This one I would like your opinion on. I have enabled a testimage in
> > my local AUH configuration but when upgrading something the message is
> > always that 'qmp' cannot be found. I adjusted auh now such that this
> > is detected from the image passed via 'testimage' in the conf file.
> > However it could also be that I'm overlooking something, in that case a=
pologies.
>
> Can you provide a simple way to reproduce and observe this? It looks
> like a complicated workaround for an issue that is not fully
> understood.
>
> This particular feature of AUH is not used in the autobuilder jobs,
> and AUH has no tests of its own, so it's prone to regressions. And if
> I didn't inherit the code from somewhere else, I would just throw it
> all away and do a clean rewrite (possibly as a devtool
> plugin/command). It barely works :)
>
> Alex

