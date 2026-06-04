Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05B9CD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 11:42:12 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9386.1780573329665554441
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 04:42:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dgI6cVuR;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5174a1d78f8so5514141cf.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 04:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780573329; cv=none;
        d=google.com; s=arc-20240605;
        b=kzYOZ56niafKHeuiiCCG3nPrDOv5kT/SXOtKRg8DyU/0DHiNrZkWx1Qqzux7y9V8k5
         VB9D4wSYIRjo2VthENzhitxbSJp2UIIqBJ+mpxKzzN4WIrmK/7OAnE1yTNeBdq9xKb7v
         rqEfYfi94idFzZ+E7/67m+LfrLmjw6IEJYO75jtNphsfhe7A3Crf2YPy9hR/lqR0B6PI
         fgQkf4RwYx3o3f6+6p5vN+GAZCVYpzOjNyU6rOXF/A0J4jPYZ2wkxE0CyL8N5Fxj+nKJ
         buvhXGwCczGkoTi56TLLDTnB3HJLYW6B6I9i6+HzkyIsu1ZF7vnFH716ukdPVl1U0+14
         Rlrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1pEhSuoyVJKDRgAGyIDgeOOS0Y8sWMNsbJb+OuqXD8c=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=U3oOzuRJA51oA50FlqPS2X6AIP/h7mBb1Lopo95THNJEtBZ6c8s2Q2C5uk6lNF+3dg
         zLeCVXcmSMPVzSxcsHbizLoPzeMydIOPhfzkwrzb/2T7UOUJI4Q3DVVs1xAUKZ3mafwz
         Wg2gzUqWAOH18lg7OGDRBT36bvsXgR+fza/wHof9CqeaHarOe5ZZ2UQ9PCiqmivHYMbM
         gH0zg3MC6xkTHk17yR+1upgOl3JXR5pN6TVsx9kMMRtf6gQqOlt7dTFepGToII9WBwT6
         zD74hGpD7jKOS0peniwRQkyKzaBV4Er7Kq5fV8bDgP0jsMz7iOv0YGnrk0CNB4BtH61V
         gUjw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780573329; x=1781178129; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1pEhSuoyVJKDRgAGyIDgeOOS0Y8sWMNsbJb+OuqXD8c=;
        b=dgI6cVuRgRtwGwKw7a2M/MyJJfiYbyCdc4211MU7aBTRvcgMBSDm5i6XpejuTSoMXF
         JNUkqr/yigdUHrkBmDV2mLGkNVAYIGB65uPDcqT98pLM8ZwcnRE1dtxvQPJ7O8D3cPor
         28Uj4rXXHdUBwcLnUl1iJirESuI3x59ePYzJiv6IzdY+gNQGfNnk/vcN7fS1LLO60H9G
         F5W4KJYzbL8ZZErIrqEX/sd7nIOYtJGI3JA0yaAfcwFlUCP5tX7gsmy/k+PZOyR0/GP1
         2R2ngRElea6nl18isG0dS+7NMAgltvbrj0ggMeHIWFc5+vdvjtoVkQOLy6wRA4cCQLtJ
         bQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780573329; x=1781178129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pEhSuoyVJKDRgAGyIDgeOOS0Y8sWMNsbJb+OuqXD8c=;
        b=riGDOdJcyYCrv6u35mX6eHHCFGd/PS2g+ppSn2LtU8qO4mZ8Kt/B4Kp4W4yesaQ4u9
         l6SpeGx8XaRn0DMEd9pln5Sk5viUdfE52XgloD8CIUhB/ALKz4MAHQ01dxxSLwbLOSuJ
         +adI1EVmZdV8PC+3U3FJsFwOyXaHc7R0AQdSrwmsuX0hAZ4CF88/mxVsZKpmBkfBAkNA
         LQ5q7pAXvS1X+JYGJNxkMHaNRYvyNQdDTEmTL8OVk/Pq6yT4tdx03BjOUYPBQKy/diPK
         CBB4uieiDYL6X3cyPDL19ss9fnVcLw8vb+EvKpvJmuZx3cobcL5xvevYicIz7b1GdGEA
         PzeQ==
X-Gm-Message-State: AOJu0YxdHFGUHctwDviGRksgY8Ih3VszyCyL4WzW81Q0oymrEHl7j64c
	EJGBIIjlblQz/7WO+p8p5UvOzgc9bPbvV4J+kfn8/Gg2YJOUQxcAbi2JWxpx0P4PdmBNHAae92w
	YAVquy7AfF9iN5YbRyHVM//vfqTDDDrQ=
X-Gm-Gg: Acq92OFiGQgD8Fyn+yWNWl0p/UWb7whqGN94FC6ybuR7+CjBTwGaK8D05+BH1V+opIr
	xq1x80uv3H45NCQwRL9AVb9HFydKlPdfDaxXnjb17HBEBT5epFViLCHzMV5UlSHv6IIv08zR5b+
	Up139evLCc420WyUX3oyFC6Il6nYP1c4WbcwEeMsRzy3e6R7eJRVkWxX4NZTx1cYW1YgQkUdxvK
	zxg9jlEAF9WiB8qME2FNptG2Ls8Nfpt8X5wfcE6G2y7ujmixCjhDg5NpJt5GPVdRjGLfFiicjBH
	TFUV5DH3JCS5yU7tqu0gL+sEgSEiBz+QT/hziaOeagG+XE1vETJq
X-Received: by 2002:a05:622a:4018:b0:517:8529:6f29 with SMTP id
 d75a77b69052e-51785297cb2mr62949991cf.27.1780573328564; Thu, 04 Jun 2026
 04:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260603174448.3479497-1-daniel.turull@ericsson.com>
In-Reply-To: <20260603174448.3479497-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 4 Jun 2026 13:41:55 +0200
X-Gm-Features: AVVi8CdkAAGJClcDlpCwVNgg9dv20y0Cz1pmbynLQ8I13yfw6gZ2off8qxpIPYY
Message-ID: <CANNYZj9nLc8tdUOmFXHHnpa77MVDPTzTmCoNzgfh87Bjw9OPhA@mail.gmail.com>
Subject: Re: [AUH] [PATCH v2 2/2] upgrade-helper: remove unused UpgradeNotNeededError
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 11:42:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4140

Thanks, applied and pushed.

Alex

On Wed, 3 Jun 2026 at 19:44, <daniel.turull@ericsson.com> wrote:
>
> From: Daniel Turull <daniel.turull@ericsson.com>
>
> UpgradeNotNeededError is never raised anywhere in the codebase.
> Remove the class definition and all references to it.
>
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
> ---
>  modules/errors.py     | 7 -------
>  modules/statistics.py | 4 +---
>  upgrade-helper.py     | 6 ++----
>  3 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/modules/errors.py b/modules/errors.py
> index 7adb103..9e8e6c9 100644
> --- a/modules/errors.py
> +++ b/modules/errors.py
> @@ -89,13 +89,6 @@ class UnsupportedProtocolError(Error):
>      def __str__(self):
>          return "Failed(Unsupported protocol)"
>
> -class UpgradeNotNeededError(Error):
> -    def __init__(self):
> -        super(UpgradeNotNeededError, self).__init__("Recipe already up to date")
> -
> -    def __str__(self):
> -        return "Failed(up to date)"
> -
>  class EmptyEnvError(Error):
>      def __init__(self, stdout):
>          super(EmptyEnvError, self).__init__("Empty environment returned", stdout)
> diff --git a/modules/statistics.py b/modules/statistics.py
> index 864cce8..227f0be 100644
> --- a/modules/statistics.py
> +++ b/modules/statistics.py
> @@ -34,9 +34,7 @@ class Statistics(object):
>          self.total_attempted = 0
>
>      def _update(self, pn, new_ver, maintainer, error):
> -        if type(error).__name__ == "UpgradeNotNeededError":
> -            return
> -        elif error is None:
> +        if error is None:
>              status = "Succeeded"
>          else:
>              status = str(error)
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 46311f0..913bd87 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -49,7 +49,7 @@ import shutil
>  sys.path.insert(1, os.path.join(os.path.abspath(
>      os.path.dirname(__file__)), 'modules'))
>
> -from errors import Error, EmptyEnvError, UpgradeNotNeededError, UnsupportedProtocolError
> +from errors import Error, EmptyEnvError, UnsupportedProtocolError
>
>  from utils.git import Git
>  from utils.devtool import Devtool
> @@ -527,9 +527,7 @@ class Updater(object):
>
>                  I(" %s: Upgrade SUCCESSFUL! Please test!" % pkggroup_name)
>              except Exception as e:
> -                if isinstance(e, UpgradeNotNeededError):
> -                    I(" %s: %s" % (pkggroup_name, e.message))
> -                elif isinstance(e, UnsupportedProtocolError):
> +                if isinstance(e, UnsupportedProtocolError):
>                      I(" %s: %s" % (pkggroup_name, e.message))
>                  else:
>                      if not isinstance(e, Error):
> --
> 2.51.0
>

