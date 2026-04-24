Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DEBFED3CE
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 14:04:59 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23125.1777039497652838863
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 07:04:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Vzus1l1x;
 spf=pass (domain: gmail.com, ip: 209.85.217.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-6108228a851so2663772137.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 07:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777039496; cv=none;
        d=google.com; s=arc-20240605;
        b=PWxnVbZBdoDVul3qNLdjXNVbnzxaDPOZ8+FufjU+VkqyLZlUhHQDm8XusOI5Qvv6Tr
         DIxi8eI3kywxaiV233aCxcSLvBvBR0B32A8EOxam/SFv8z4Lf2i0DhCr2k7OvO7jOUAb
         rhRQMiYNrpxy2ELjxdA0aOsyOhXPuC3DnfLBlPD9HWcl7O1sbV6icrNgRAy/yYbH+bAA
         /WzT6W2JUZTIkBJUqw4LlnTNggGXaOtYnVk6f4rmc+EoEsiBfTCw08TdNd4/Wlmt+5N6
         dhKUmqeOTcUPEhDT+jmQNl0nYE1uWNgPA3KsO+cIXNWNDVbGGYjXcxdKblL1CQmAub4t
         9Rjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=giHErWYzEjeW3XwaSWpHQtmFHGyKIbxorYxcOtwsiy4=;
        fh=dl6hDswrRM/UxJNnYCvEBdIZalBhgR71Ri7j4SsRvWI=;
        b=Nxr/zlwda5KSBjWLPcM8IfeMQ3nN5v/Vh95IgzWfl1qHzGqJnsgEySm/3VeL9rtmKM
         rtDDwXe+A0C3zy4jC6/Rz3BzLJER1s97+EMLif7I9vKsccrY9DFy2MIRso7mDFYyF9n6
         uZpd5VuLcTQ6FIFXtZD5d7EZqyEp1GxWXL8gbkeczy4chuXo7dpbyHPepqyArlKix5w2
         GfhzJ3SBJxiloxZbmdohbhSS97cHMwbSBrvVkI/uprNww35X9ie1kbdPOjUhYR31Vf3i
         pOz+3fWCCUzoKQq6AQ2jW4ylqvMTVGVVdds3gkeSQJ/kuZiYoMoH0NuCIYNRRmSQGHQ0
         ID1Q==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777039496; x=1777644296; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=giHErWYzEjeW3XwaSWpHQtmFHGyKIbxorYxcOtwsiy4=;
        b=Vzus1l1xUaxUp9cQKQauRI8em7pFz1xbCcJ4pZ950PBkVfojwa8q2U0U6Qr4WYedFD
         sNwMh2iD8EG/TPeiSOkUwuqXR2gFOoQDKPNhD7AkTgqNLPiEVxkRxZB1irHLUSInaeao
         otBedIZtNW+WxXxVKNgH5EZKLC2sn7KaM9B9CWYZ+EUq5ecyB53iSX6kj7wqo5GjSIXI
         KCl05vNYR711FWE0nBaejHS2HPB9p3l4HWbN7NR4iRKL1SzgSF/Bs5nhkefg+vomim1V
         rxRMkuOFj6b/6aaZPt6IBoTYJmqD08IOzP0LahAvv1muHN7cxIK6+r06/majeVuXnGiL
         /Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777039496; x=1777644296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giHErWYzEjeW3XwaSWpHQtmFHGyKIbxorYxcOtwsiy4=;
        b=TpAGMtLpFURD+Y1UcgzdQpQ4zB6urBLVhD17bCulF5fNiixvTGG22sy2IAlRTex1iN
         KLoSkOOEZv7qzbDiykcSk4gpnWQ1hNyrABTmN3MCv/I3sHBoaiX1H4cIX4qriNgYqarb
         ZVGBGYkUZ4EXYjoxHVU2eawb3b1qw8jHnaAyKdGNvMG7P0BCMVfB3rqh6qUiWfMkxVbj
         wndBjSxUfh79JcpaFPS6G2cghoYMN4PYNsf2e9/C8YnT8hlkBkKOy3VRiamL7Yw2Ujnq
         KCTE842cVlMfKdmHs91YxN+hoAN5CxcOHl/gS1tZp5ZVt2I6r6a18lnCGo54rVW7pxnt
         O0WA==
X-Gm-Message-State: AOJu0YxH6rKkzof0jOsu1BEErmwlusWEGqF5fJpov5YNXJFyQ1KqDXJR
	Y9x7luaBH0KmymQqJ3MvBxJIqhB5jwhM7AVD+QVf35nqQVP2yqKlMZCFTuCwCcJYncbo/RFNs5i
	tXNYgBC57TxeICBDAeWzCxWIQ0ARBWgA=
X-Gm-Gg: AeBDieuabsEwMSuN5eDGEpLg3Ij13sLeAEOMBQR1eLa/cBwNnX2oFHh6X1cdwJkXJRj
	tUWixPeBxv2R28fJBi6T5QVcR/I9nRxIN6fVpCro1DuNmMj7f3CJkYJYQLgil+/NAE9BsHcvDdA
	3Vc8mm0AAoxhCUkCMdG7YRUTn17mf74IXlI7LYZLDApGL7AwgMMjWXSOKcu4qgSiDnZyWJE19mO
	R1dCwDnF4wsuxUWHwzEiUsy3C5DdN7v5cayPhsT8FjdOOtEabp+XxYzlzJ21gdS+FejmXaRJYop
	Z29fiAv8yq95a4ExaMT7ITSX0T/j1gU1y8H6DgkSjfUbqfP3n2Rq
X-Received: by 2002:a05:6102:3588:b0:5ff:2963:52dc with SMTP id
 ada2fe7eead31-616f474365amr15515964137.4.1777039496376; Fri, 24 Apr 2026
 07:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260414053202.3869771-1-Qi.Chen@windriver.com> <20260414053202.3869771-2-Qi.Chen@windriver.com>
In-Reply-To: <20260414053202.3869771-2-Qi.Chen@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 24 Apr 2026 16:04:45 +0200
X-Gm-Features: AQROBzD-6xqZ4RxKUsPEMYc4NdL8N9wDK7RYDrpVZXtbOus0EtrtbnKI0R2BIgU
Message-ID: <CANNYZj9PmjiMDbz6jknMrYubDx=xk5cW2KeGJXVyHCNbFhkpAw@mail.gmail.com>
Subject: Re: [auh][PATCH 2/3] modules/steps.py: refactor compile() to use
 parallel per-machine builds
To: Qi.Chen@windriver.com
Cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 14:04:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3802

I understand the idea, but unfortunately I do not think we can put
this (and the following patch) on the Yocto autobuilder. The
expectation for the builder jobs is that they are expected to run only
one Yocto build at a time, and the autobuilder will:

- configure each builder to use carefully adjusted limited resources
for that one build (via the fragment in oe-core)
- start several builders on each worker machine to parallelize large
builds (e.g. a-full), but no more than a certain upper limit, and
queue them if the limit is reached on all workers

This patch breaks that expectation, as auh build is not using an
exclusive worker for itself, and shares workers with other builds.

It also isn't clear how this patch was tested and benchmarked. Did you
run a substantial upgrade job with it? Did you see a significant
speedup?

Alex


On Tue, 14 Apr 2026 at 07:32, <Qi.Chen@windriver.com> wrote:
>
> From: Chen Qi <Qi.Chen@windriver.com>
>
> Reasons:
>
> 1. Building recipes one by one consumes little build resource. In practice,
>    when building one recipe machine by machine in a serialized way, the
>    machine load is very very low. This means AUH is not making use of
>    the machines' computing resources.
> 2. Yocto project has good and mature technique to control the build to
>    not exhaust machines' resource, e.g., BB_NUMBER_THREADS, BB_PRESSURE_MAX_XXX.
>    So we really don't need to worry about AUH exhausting server resources.
>
> Technical Details:
>
> 1. Each machine gets its own build directory ($BUILDDIR-{machine}) with
>    BUILDDIR and BBPATH env vars set accordingly, and conf/ copied from the
>    original build directory. All machines compile in parallel via
>    multiprocessing.Pool, with errors collected and reported after all
>    workers complete.
>
> 2. Use original build directory for the first machine in parallel build.
>    Skip creating a separate build directory for the first machine and
>    build directly in the original BUILDDIR. Only the remaining machines
>    get their own $BUILDDIR-{machine} copies. The purpose is that if testimage
>    is enabled, then the build can just the previous results.
>
> 3. Always refresh per-machine conf/ directory before compilation. This
>    ensure anything new in the main build directory will get into new
>    build directory.
>
> 4. Add --serial-build option to use sequential per-machine compilation.
>    When --serial-build is passed, compile each machine serially using the
>    original build logic instead of the parallel multiprocessing approach.
>
> Note:
>
> After this change, AUH will use parallel build by default. The '--serial-build'
> is there if users really need to use serial build for some reason.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  modules/steps.py  | 96 +++++++++++++++++++++++++++++++++++++----------
>  upgrade-helper.py |  3 ++
>  2 files changed, 80 insertions(+), 19 deletions(-)
>
> diff --git a/modules/steps.py b/modules/steps.py
> index a6ec341..300ae72 100644
> --- a/modules/steps.py
> +++ b/modules/steps.py
> @@ -22,10 +22,12 @@
>  import os
>  import shutil
>  import re
> +import multiprocessing
>
>  from logging import debug as D
>  from logging import info as I
>  from logging import warning as W
> +from logging import error as E
>
>  from errors import Error, DevtoolError, CompilationError
>  from buildhistory import BuildHistory
> @@ -104,31 +106,87 @@ def devtool_upgrade(devtool, bb, git, opts, group):
>      for p in group['pkgs']:
>          _devtool_upgrade(devtool, bb, git, opts, p)
>
> -def _compile(bb, pkg, machine, workdir):
> -        try:
> -            bb.complete(pkg, machine)
> -        except Error as e:
> -            with open("{}/bitbake-output-{}.txt".format(workdir, machine), 'w') as f:
> -                f.write(e.stdout + e.stderr)
> -            for line in e.stdout.split("\n") + e.stderr.split("\n"):
> -                # version going backwards is not a real error
> -                if re.match(".* went backwards which would break package feeds .*", line):
> -                    break
> -                # 'not in COMPATIBLE_HOST/MACHINE is not a real error
> -                if re.match(".*not in COMPATIBLE.*", line):
> -                    break
> -            else:
> -                raise CompilationError()
> +def _compile_worker(args):
> +    """Worker function for multiprocess compilation. Runs in a separate process."""
> +    pkg, machine, workdir, orig_builddir, use_orig = args
> +    from utils.bitbake import Bitbake
> +
> +    if use_orig:
> +        builddir = orig_builddir
> +    else:
> +        builddir = "{}-{}".format(orig_builddir, machine)
> +        os.makedirs(builddir, exist_ok=True)
> +
> +        new_conf = os.path.join(builddir, "conf")
> +        if os.path.isdir(new_conf):
> +            shutil.rmtree(new_conf)
> +        shutil.copytree(os.path.join(orig_builddir, "conf"), new_conf)
> +
> +    os.environ["BUILDDIR"] = builddir
> +    os.environ["BBPATH"] = builddir
> +
> +    bb = Bitbake(builddir)
> +    try:
> +        bb.complete(pkg, machine)
> +        return (machine, True, None)
> +    except Error as e:
> +        with open("{}/bitbake-output-{}.txt".format(workdir, machine), 'w') as f:
> +            f.write(e.stdout + e.stderr)
> +        for line in e.stdout.split("\n") + e.stderr.split("\n"):
> +            if re.match(".* went backwards which would break package feeds .*", line):
> +                return (machine, True, None)
> +            if re.match(".*not in COMPATIBLE.*", line):
> +                return (machine, True, None)
> +        return (machine, False, e.stdout + e.stderr)
> +
> +def _compile_serial(bb, pkg, machine, workdir):
> +    """Compile a single machine serially (original behaviour)."""
> +    try:
> +        bb.complete(pkg, machine)
> +    except Error as e:
> +        with open("{}/bitbake-output-{}.txt".format(workdir, machine), 'w') as f:
> +            f.write(e.stdout + e.stderr)
> +        for line in e.stdout.split("\n") + e.stderr.split("\n"):
> +            if re.match(".* went backwards which would break package feeds .*", line):
> +                break
> +            if re.match(".*not in COMPATIBLE.*", line):
> +                break
> +        else:
> +            raise CompilationError()
>
>  def compile(devtool, bb, git, opts, group):
>      if opts['skip_compilation']:
>          W(" %s: Compilation was skipped by user choice!" % group['name'])
>          return
>
> -    for machine in opts['machines']:
> -        I(" %s: compiling upgraded version for %s ..." % (group['name'], machine))
> -        _compile(bb, " ".join([pkg_ctx['PN'] for pkg_ctx in group['pkgs']]), machine, group['workdir'])
> -        if opts['buildhistory'] and machine == opts['machines'][0]:
> +    pkg = " ".join([pkg_ctx['PN'] for pkg_ctx in group['pkgs']])
> +    machines = opts['machines']
> +
> +    if opts.get('serial_build'):
> +        for machine in machines:
> +            I(" %s: compiling upgraded version for %s ..." % (group['name'], machine))
> +            _compile_serial(bb, pkg, machine, group['workdir'])
> +            if opts['buildhistory'] and machine == machines[0]:
> +                I(" %s: Checking buildhistory ..." % group['name'])
> +                group['buildhistory'].diff()
> +    else:
> +        orig_builddir = os.environ.get("BUILDDIR", "")
> +        worker_args = [(pkg, m, group['workdir'], orig_builddir, i == 0) for i, m in enumerate(machines)]
> +
> +        I(" %s: compiling upgraded version for %s in parallel ..." % (group['name'], machines))
> +        with multiprocessing.Pool(processes=len(machines)) as pool:
> +            results = pool.map(_compile_worker, worker_args)
> +
> +        os.environ["BUILDDIR"] = orig_builddir
> +        os.environ["BBPATH"] = orig_builddir
> +
> +        failed = [(m, err) for m, ok, err in results if not ok]
> +        if failed:
> +            for m, err in failed:
> +                E(" %s: compilation failed for %s" % (group['name'], m))
> +            raise CompilationError()
> +
> +        if opts['buildhistory'] and machines:
>              I(" %s: Checking buildhistory ..." % group['name'])
>              group['buildhistory'].diff()
>
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 2ceb722..1c05333 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -108,6 +108,8 @@ def parse_cmdline():
>                          help="layers to include in the upgrade research")
>      parser.add_argument("--layer-dir", action="store", default='',
>                          help="the layers root directory")
> +    parser.add_argument("--serial-build", action="store_true", default=False,
> +                        help="compile for each machine serially instead of in parallel")
>      return parser.parse_args()
>
>  def parse_config_file(config_file):
> @@ -193,6 +195,7 @@ class Updater(object):
>          self.opts['author'] = "Upgrade Helper <%s>" % \
>                  settings.get('from', 'uh@not.set')
>          self.opts['skip_compilation'] = self.args.skip_compilation
> +        self.opts['serial_build'] = self.args.serial_build
>          self.opts['buildhistory'] = self._buildhistory_is_enabled()
>          self.opts['testimage'] = self._testimage_is_enabled()
>
> --
> 2.49.0
>

