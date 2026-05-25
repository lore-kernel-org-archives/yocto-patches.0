Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F46DCD5BB1
	for <webhook@archiver.kernel.org>; Mon, 25 May 2026 16:05:09 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18950.1779725101483724196
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 25 May 2026 09:05:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Wg6nEdsL;
 spf=pass (domain: gmail.com, ip: 209.85.161.46, mailfrom: twoerner@gmail.com)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-69d8ff0ca12so1802300eaf.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779725101; x=1780329901; darn=lists.yoctoproject.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEbKIbb601159ahaFZJMtru5qK+0UTO3/17JaKw3qtc=;
        b=Wg6nEdsLQ51+DqQEDbQD0WojVrNcmYZat7u49WNKeSuBdHMt7l0FPi+xY0sfkXZ05Z
         2b0GYKcGikolUEPgz4YGgzqe5kQzhVvmW/8kefE16VipL6hz+YTLNV/t+wXEn9Bayhnm
         4+s3qvb1fUxVu+PKUALv+YvKHZivKr5JihkUTUajaPUTzvNW/x2vFL8iLuBj7SB5Z7NS
         By94drJvkD1xx8GIDhATmfBuje1ht3/Na6Tbc4v8wTcz+eWJUpRkuqw2EI71doleEN+d
         ITM2csCr+027zfrcMHVmcZNV/hnYDcQ8a7f2tqbo4IPYdrNWaY1Gyeb5D4CdEFlBMR6X
         fHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725101; x=1780329901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEbKIbb601159ahaFZJMtru5qK+0UTO3/17JaKw3qtc=;
        b=gct0KOdB3LCPQj9A+ffNMfFo03c/cuIJipNXBuc8iU1KRXz5/l1mW1z++dhFwSVLOP
         q5AVORuAE/XHz6GiWgMdwzUEq9FZE+KO1JruUoyXcAktjfZvJQmGJw3QB0sWwidUAes5
         AiqdKQplG3e8mWaxs+M13zePc3qTaDHUwXnwr8SnBBBoZOLWgGTXfrwOEJ94XOAASbt3
         Qu45IV03v48tf0nrhW/61wFQGiTGw1E6vzobNuf2DKOnFtSFfzzmKhz80ettWOVy4ozL
         6mxJK0pWev3MytJTXLl6G9obEvYoGafwKWDhHAx1W5AAPFIpA90qdkPJ6ob9A3d3uFdg
         0x/A==
X-Gm-Message-State: AOJu0YyPZyD12Gj3RU6PZg9GzGPtQk9KZ7nfJ8D+KW5RXFjL6GHDQ7N9
	2ARMC7Hu5gK3WiKHmXfhol3UFglYwEvfJxOIIv4di7ye4M1oVDCKPJR+6YH3Gw==
X-Gm-Gg: Acq92OF8m6vYV1qPZWJGoGCn+jgfi5R/rJ5VfNBnrmnnHQl+S1cGbWLkeHO+z8kb7t3
	gzT5wpwEHTiE4i2Bn0IE/DdJnyXSIalJ07IEt09hm9I8SqLS19x87NKAHh3l6xsCRHimpMLAgjZ
	lwhyb2wQKFO5yK7uk3d8Z6Yt2Tq1XvZnd3DUfypxct5GUhjHse7evbEQ+NGNUSUMZj+IHDv45Rd
	XRlgY+i1f7MY7xFbaS2a51vN8Ewkn9TwUAoc0TsalR8lYLiyjcGzsw6XwnSpils7wOmw66HiDgX
	ttNtaNREHbI+annyh39TfsNTi3Ykc5twOl1AkeuCM477iR5XThtMK10AydE8LpVWr19bcvdS4xk
	LxENCWJw+QIcevwEQk+UrWkwzqwUJKzzRUL5/WQvCMbyRI6sE6YHQa9UAzrpnoAWJhNeIXo4LlZ
	dlDX28gAM9I0OipN94bEJjOcd0k33MVkVyUaHn9blmD0/IWDkWbLQ7V1d216tLubIBMg==
X-Received: by 2002:a05:6820:4dc1:b0:68c:a4ce:4e8 with SMTP id 006d021491bc7-69d7ec5ae7fmr8051781eaf.38.1779725100560;
        Mon, 25 May 2026 09:05:00 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cca9c02e56sm15822036d6.43.2026.05.25.09.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:04:59 -0700 (PDT)
Date: Mon, 25 May 2026 12:04:57 -0400
From: Trevor Woerner <twoerner@gmail.com>
To: Hongxu Jia <hongxu.jia@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [wic][PATCH] Fix bb and oe module confliction
Message-ID: <ahRzKRhG2sutVu3g@localhost.localdomain>
References: <20260428120602.2881446-1-hongxu.jia@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428120602.2881446-1-hongxu.jia@windriver.com>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 25 May 2026 16:05:09 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4044

Hi,

Thanks for this patch, I will apply it after fixing up some wording.

On Tue 2026-04-28 @ 05:06:02 AM, Hongxu Jia wrote:
> While adding nativesdk-wic to buildtools-extended-tarball and using
> it for bitbake build, it triggered failure
> [snip]
> $ which wic
> path-to/buildtools.buildtools-extended-standalone-10.26.17.0/sysroots/x86_64-wrlinuxsdk-linux/usr/bin/wic
> 
> $ bitbake core-image-minimal
> ERROR: Unable to parse Var <METADATA_BRANCH[:=]>
> Traceback (most recent call last):
>   File "oe-core/bitbake/lib/bb/data_smart.py", line 465, in expandWithRefs
>     s = __expand_python_regexp__.sub(varparse.python_sub, s)
>   File "oe-core/bitbake/lib/bb/data_smart.py", line 154, in python_sub
>     value = utils.better_eval(codeobj, DataContext(self.d), {'d' : self.d})
>   File "oe-core/bitbake/lib/bb/utils.py", line 489, in better_eval
>     return eval(source, ctx, locals)
>   File "Var <METADATA_BRANCH[:=]>", line 1, in <module>
> AttributeError: module 'oe' has no attribute 'buildcfg'
> [snip]
> 
> In order to avoid confliction with oe module in oe-core and
> bb module in bitbake, move src/bb -> src/wic/bb, src/oe -> src/wic/oe,
> rename oe to wic.oe, bb to wic.bb
> 
> After apply the patch to wic recipe locally, run oe-selftest wic case
> $ oe-selftest -r wic
> ...
> 2026-04-28 20:00:03,230 - oe-selftest - INFO - SUMMARY:
> 2026-04-28 20:00:03,230 - oe-selftest - INFO - oe-selftest () - Ran 95 tests in 7853.682s
> 2026-04-28 20:00:03,230 - oe-selftest - INFO - oe-selftest - FAIL - Required tests failed (successes=87, skipped=1, failures=0, errors=7)
> 
> PS: the FAIL cases are about qemu related about `Permission denied on tap'
> 
> Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
> ---
>  pyproject.toml                              | 4 ++--
>  src/{ => wic}/bb/__init__.py                | 0
>  src/{ => wic}/bb/utils.py                   | 0
>  src/{ => wic}/oe/__init__.py                | 0
>  src/{ => wic}/oe/bootfiles.py               | 0
>  src/{ => wic}/oe/path.py                    | 2 +-
>  src/wic/plugins/imager/direct.py            | 2 +-
>  src/wic/plugins/source/bootimg_partition.py | 2 +-
>  src/wic/plugins/source/rootfs.py            | 2 +-
>  9 files changed, 6 insertions(+), 6 deletions(-)
>  rename src/{ => wic}/bb/__init__.py (100%)
>  rename src/{ => wic}/bb/utils.py (100%)
>  rename src/{ => wic}/oe/__init__.py (100%)
>  rename src/{ => wic}/oe/bootfiles.py (100%)
>  rename src/{ => wic}/oe/path.py (99%)
> 
> diff --git a/pyproject.toml b/pyproject.toml
> index 6ef2946..fdc1ce0 100644
> --- a/pyproject.toml
> +++ b/pyproject.toml
> @@ -25,10 +25,10 @@ Repository = "https://git.yoctoproject.org/wic"
>  wic = "wic.cli:main"
>  
>  [tool.hatch.build]
> -packages = ["src/wic", "src/oe", "src/bb"]
> +packages = ["src/wic"]
>  
>  [tool.hatch.build.targets.wheel]
> -packages = ["src/wic", "src/oe", "src/bb"]
> +packages = ["src/wic"]
>  
>  [build-system]
>  requires = ["hatchling>=1.21"]
> diff --git a/src/bb/__init__.py b/src/wic/bb/__init__.py
> similarity index 100%
> rename from src/bb/__init__.py
> rename to src/wic/bb/__init__.py
> diff --git a/src/bb/utils.py b/src/wic/bb/utils.py
> similarity index 100%
> rename from src/bb/utils.py
> rename to src/wic/bb/utils.py
> diff --git a/src/oe/__init__.py b/src/wic/oe/__init__.py
> similarity index 100%
> rename from src/oe/__init__.py
> rename to src/wic/oe/__init__.py
> diff --git a/src/oe/bootfiles.py b/src/wic/oe/bootfiles.py
> similarity index 100%
> rename from src/oe/bootfiles.py
> rename to src/wic/oe/bootfiles.py
> diff --git a/src/oe/path.py b/src/wic/oe/path.py
> similarity index 99%
> rename from src/oe/path.py
> rename to src/wic/oe/path.py
> index 47b0c13..3e95ea0 100644
> --- a/src/oe/path.py
> +++ b/src/wic/oe/path.py
> @@ -10,7 +10,7 @@ import shutil
>  import subprocess
>  import os.path
>  
> -import bb
> +import wic.bb as bb
>  
>  def join(*paths):
>      """Like os.path.join but doesn't treat absolute RHS specially"""
> diff --git a/src/wic/plugins/imager/direct.py b/src/wic/plugins/imager/direct.py
> index 832d0e6..3a4f067 100644
> --- a/src/wic/plugins/imager/direct.py
> +++ b/src/wic/plugins/imager/direct.py
> @@ -19,13 +19,13 @@ import uuid
>  
>  from time import strftime
>  
> -from oe.path import copyhardlinktree
>  
>  from wic import WicError
>  from wic.filemap import sparse_copy
>  from wic.ksparser import KickStart, KickStartError
>  from wic.pluginbase import PluginMgr, ImagerPlugin
>  from wic.misc import get_bitbake_var, exec_cmd, exec_native_cmd
> +from wic.oe.path import copyhardlinktree
>  
>  logger = logging.getLogger('wic')
>  
> diff --git a/src/wic/plugins/source/bootimg_partition.py b/src/wic/plugins/source/bootimg_partition.py
> index cc121a7..96f5e14 100644
> --- a/src/wic/plugins/source/bootimg_partition.py
> +++ b/src/wic/plugins/source/bootimg_partition.py
> @@ -16,12 +16,12 @@ import logging
>  import os
>  import re
>  
> -from oe.bootfiles import get_boot_files
>  
>  from wic import WicError
>  from wic.engine import get_custom_config
>  from wic.pluginbase import SourcePlugin
>  from wic.misc import exec_cmd, get_bitbake_var
> +from wic.oe.bootfiles import get_boot_files
>  
>  logger = logging.getLogger('wic')
>  
> diff --git a/src/wic/plugins/source/rootfs.py b/src/wic/plugins/source/rootfs.py
> index 06fce06..dca4106 100644
> --- a/src/wic/plugins/source/rootfs.py
> +++ b/src/wic/plugins/source/rootfs.py
> @@ -16,12 +16,12 @@ import os
>  import shutil
>  import sys
>  
> -from oe.path import copyhardlinktree
>  from pathlib import Path
>  
>  from wic import WicError
>  from wic.pluginbase import SourcePlugin
>  from wic.misc import get_bitbake_var, exec_native_cmd
> +from wic.oe.path import copyhardlinktree
>  
>  logger = logging.getLogger('wic')
>  
> -- 
> 2.49.0
> 

