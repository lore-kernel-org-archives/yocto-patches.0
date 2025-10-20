Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D68CCD19F
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 23:35:25 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web11.6540.1761003321197160544
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Oct 2025 16:35:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=gOzYY6rX;
 spf=pass (domain: konsulko.com, ip: 209.85.219.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7ea50f94045so87991016d6.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 16:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1761003320; x=1761608120; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBKN+SEKL+PFnDh49RpvYqOMcogEgi2e9D5B5yNfXHw=;
        b=gOzYY6rXWQX7tkauBJX3XyJz5x+7IG31H1o2iuWU7BUBMvPYUFrh6y9TEUfLs71Qdp
         /F+i7/KjI2C0nkzADCoTiKfa4cNB2fQJp9Fr9jHgN995H5RIcjSzDTo8GOc4jx6DxPqb
         ibvllyxBvIDvztSnOpXyaKOm1s/TGoeZFW+EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761003320; x=1761608120;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBKN+SEKL+PFnDh49RpvYqOMcogEgi2e9D5B5yNfXHw=;
        b=pFICCxX6FCZCySvw6vyCSoxDxnvzeaXSBObC/rRliKuoEhIewMneV4/5JMqpz9Es58
         Nzzfk7AE+fpGV6czHhLi/l9PiUmJNvn+xicUkgBTPv3G3mAtML8cWyCop2yrgFNmmZrn
         OqrdXairMPvEqERnPVZIA5Xxv/WeVFUD1/SUA3OzVb/7E/wQMjP19rQTFhDh/q/tMB4r
         ryvVnbMbxnVhq+T7kBjYajiFpR3pH59FaqBUkF+PfVYQfyRPiDW6sU1AlkKIJbnJ2nsV
         t9jWkUb1Vd2xI+6Th+N/mDE7ZmPgZHNak3l5msP7dnuWPBBgqg4Jtk95sj+/9XFraDcc
         SLJw==
X-Gm-Message-State: AOJu0YyERJtnJN5yovMISX5C+2TLD5BWZXJQknwwdqro7mkI0k+tbR3R
	UPMSbNlkf3u9u3h6skqPQkQXFZEcChCmB/y7xtVHrcV1WIWgf3qbXaj+HXbqteoj5Rysk/Os1qb
	5MrEe
X-Gm-Gg: ASbGncu+dlv5HNDadiJ3AsH8GldqOEfx5D1ofT0tGVN5NYftxrsDtdoEKG05mdjnVd8
	csSqdaAIntAu2g2xRbeOwS7vHiS8/r2Aep4XqAeuKRDYNpD1wdW5Q4DgWBa52gQLsRyymZ7vUur
	PoahwxRoN038fzz3+5CQt6JslRqMsiJZlJpZU3D+kV5cJ4iI7yOrQGKFUtjo3QVT5ZIfyRn/j2w
	8QBUDJjVi/j7yGQt1a39yOTVtv6KyvZmxdu/GsBsZRD1hnmjxEK03hFifKQSPhJSGKog+2zSBe8
	O5eJebKYMgE0CW1SDSrD1TbTb41xZZHshvOH7nw/7FM8Wls0L5eKh0khr/Z1p7HG9CptFSBKD78
	5fAAiE+T+BHaOiJcjVNw5VvmRIeSKUx/3nBkEHHPH/wTTXdssc5xf+jKk86h/L5Yu/yT3QjgMfQ
	Vp/anLIBzFSgg4zILftFzDA4IdUqcCq/UHhJo=
X-Google-Smtp-Source: AGHT+IF7N5HalzsC9LGPOD2kJL05J4I+f92a3QhgBkGZmnkn5l19UPwKB/dSYcI96ujcPfSvpMPxvA==
X-Received: by 2002:a05:622a:138b:b0:4c7:a8ed:af3e with SMTP id d75a77b69052e-4e89cffbdf8mr213512371cf.40.1761003319526;
        Mon, 20 Oct 2025 16:35:19 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf8753dsm63518131cf.15.2025.10.20.16.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 16:35:18 -0700 (PDT)
Date: Mon, 20 Oct 2025 19:35:02 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 00/15] Assorted fixes
In-Reply-To: <186F159F658D98A3.31929@lists.yoctoproject.org>
Message-ID: <90ee11b2-ea1b-dfb0-5b7f-bace133edeac@konsulko.com>
References: <186F159F658D98A3.31929@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Oct 2025 23:35:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2370

On Thu, 16 Oct 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up contributed patches from the past few weeks,
> as well as some other fixes and cleanup.  I intend to merge these to
> master branch at end of day Monday unless there are objections.
>
> On top of the contributed patches, there are some build fixes from Marta
> that have gotten us to a working state with CI, and some hopefully
> non-controversial recipe removals from myself.  The recipes in question
> have been disabled for at least two years, and there has been no obvious
> interest in them in that period.  I have worked up a list of a few more
> recipes that were not getting tested in the CI testing that are broken
> atm, some of those may be next in line for removal if there's not a path
> to a simple fix via an upgrade.
>
> On another note, now that CI automation is working well, my thinking is
> that going forward I may usually just post a list of commits queued on
> master-next rather than these full patch series, as it's not clear the
> duplication of contributed patches provides much value.  If you have a
> strong desire to still see these explicit patch series instead, please
> reply to indicate that.

I have now merged these to master, barring the one commit from my test
branch that had slipped in that Marta pointed out.

Scott

> Changes:
>
> Clayton Casciato (2):
>   suricata: populate SYSTEMD_SERVICE for service autostart
>   suricata-update: add package to pull files
>
> Marta Rybczynska (5):
>   kas: use repo name
>   lynis: move to GitHub fetching
>   chipsec: update to 1.13.16
>   chipsec: disable until 6.16 support is fixed
>   test: allow root login for test images
>
> Scott Murray (5):
>   tripwire: Remove recipe
>   libest: Remove recipe
>   paxctl: Remove recipe
>   packagegroup-core-security: update for recent changes
>   meta-tpm: Small maintainers fix
>
> Yi Zhao (3):
>   python3-fail2ban: fix ptest failures
>   python3-fail2ban: update to latest git rev
>   libmhash: fix build with gcc 15
>
>  .../include/maintainers-meta-security.inc     |    2 -
>  docs/overview.txt                             |   27 -
>  .../fail2ban/python3-fail2ban_git.bb          |   12 +-
>  kas/kas-security-base.yml                     |    2 +-
>  kas/qemux86-test.yml                          |    1 +
>  lib/oeqa/runtime/cases/tripwire.py            |   47 -
>  .../distro/include/maintainers-meta-tpm.inc   |    1 -
>  recipes-compliance/lynis/lynis_3.1.5.bb       |    6 +-
>  .../packagegroup-core-security.bb             |   20 +-
>  .../suricata/python3-suricata-update_1.3.6.bb |   15 +
>  recipes-ids/suricata/suricata_7.0.0.bb        |    1 +
>  recipes-ids/tripwire/files/run-ptest          |    3 -
>  recipes-ids/tripwire/files/tripwire.cron      |    8 -
>  recipes-ids/tripwire/files/tripwire.sh        |    9 -
>  recipes-ids/tripwire/files/tripwire.txt       |   69 -
>  recipes-ids/tripwire/files/twcfg.txt          |   15 -
>  recipes-ids/tripwire/files/twinstall.sh       |  320 -----
>  recipes-ids/tripwire/files/twpol-yocto.txt    | 1107 -----------------
>  recipes-ids/tripwire/tripwire_2.4.3.7.bb      |   75 --
>  .../{chipsec_1.9.1.bb => chipsec_1.13.16.bb}  |    4 +-
>  recipes-security/libest/libest_3.2.0.bb       |   28 -
>  recipes-security/libmhash/libmhash_0.9.9.9.bb |    2 +
>  ...ckage-error-if-DESTDIR-is-set-to-usr.patch |   26 -
>  recipes-security/paxctl/paxctl_0.9.bb         |   40 -
>  24 files changed, 47 insertions(+), 1793 deletions(-)
>  delete mode 100644 lib/oeqa/runtime/cases/tripwire.py
>  create mode 100644 recipes-ids/suricata/python3-suricata-update_1.3.6.bb
>  delete mode 100644 recipes-ids/tripwire/files/run-ptest
>  delete mode 100644 recipes-ids/tripwire/files/tripwire.cron
>  delete mode 100644 recipes-ids/tripwire/files/tripwire.sh
>  delete mode 100644 recipes-ids/tripwire/files/tripwire.txt
>  delete mode 100644 recipes-ids/tripwire/files/twcfg.txt
>  delete mode 100644 recipes-ids/tripwire/files/twinstall.sh
>  delete mode 100644 recipes-ids/tripwire/files/twpol-yocto.txt
>  delete mode 100644 recipes-ids/tripwire/tripwire_2.4.3.7.bb
>  rename recipes-security/chipsec/{chipsec_1.9.1.bb => chipsec_1.13.16.bb} (90%)
>  delete mode 100644 recipes-security/libest/libest_3.2.0.bb
>  delete mode 100644 recipes-security/paxctl/paxctl/0001-To-fix-package-error-if-DESTDIR-is-set-to-usr.patch
>  delete mode 100644 recipes-security/paxctl/paxctl_0.9.bb
>
>

