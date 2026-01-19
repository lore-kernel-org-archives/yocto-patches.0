Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C35D29C54
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 18:03:32 +0000 (UTC)
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40809.1768845808586573671
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Jan 2026 10:03:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FnNTM9uj;
 spf=pass (domain: konsulko.com, ip: 209.85.222.194, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c6aaf3cd62so350342985a.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 10:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1768845807; x=1769450607; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZhu2mSwjyTVEYfEwBj2OUCVPvkKjilhGTsr0gPzpFk=;
        b=FnNTM9ujdQg61+khx9ie+HLsJTcJD2jhm+Tpa0VWQr77OHzPbzB+PYxhxGJB6iZ7LV
         T5o4DzJean9Pbm9y6gjifL7zYCJgJsQEuf4zshKshg2rzI4LVeLM/Wr5SI+IJruIgkRq
         Sz/I7Ayztnfeob9jcW5rfQWEYorA/qGgSBQSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768845807; x=1769450607;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZhu2mSwjyTVEYfEwBj2OUCVPvkKjilhGTsr0gPzpFk=;
        b=czW23iHUfikTBS2oBwKqMNUeFqZH8xIM3QpFa1P/GDvdi38JZH/kH0w2MnocjrTmcP
         g/ZGOH/AOPh4fu2W/9WaJp3vz7VVp6sfbOkWG0/+f8RlGf/QcFk7PIuuAYPwo/ZilI5G
         pHXXi+ehoIggjiBXarline+nc5YhIJl5qwwBi9PX3/yZ4poOR/nMAUOKRp3CS/s0vi9y
         QAXMmZMC7wDxk3fvPJUeVXxlPAdBaN213mzd6t6viU7uurwzl1qnE3NnvaQeoq3ldU4E
         pLEy17WQspMt2ds8B8Xw0SszJvAng3farnXHx3lUO0VEyhzjhnQsHIuChOVHd8gZsbqP
         apfQ==
X-Gm-Message-State: AOJu0Yw5mPl/bDYvBSZhqs13XoqDCCD6OZrLXV5FDsipIvYL+FNdSFkK
	JrYeu+2dxvGa5vn3cxOvMNx9g9jEBd1oEp8gl0VW8P3SxkZV+qhBr+T3byLga42TeY1g5C4AMjv
	Q76u5PYw=
X-Gm-Gg: AY/fxX7XFx/K7EAOM8wu5Ya8P68gjBwCHrHO5WY4Wi2gGoeYQt0XW3qmI/rHy6cp0LQ
	6haK706wKkw2nv69Gcbl4pAf554pAhhhPkxBzYl7na042dDNobHYYqh+Q+ZmUUZq5fp9iTBgDl4
	SNIGW3MeQ26jBUp0zffX1tIdkm7riiTFRlkxsZ/h1QxNvdEC/w1Gh8ZFSJtfFQvz1h/2T7wImFR
	4k+skiNc/8ytExwxgk8x28uootRqFn1YQgzFAxI1pByPyMSG1itBWoXIljREbBGmzhb7Becwqtc
	aCvUFg7GjIAJHVbI4YOeyCyWgwdalfCMRwLSY158ksiPHKcz2dg4NJLHzP0OE0goCxZx60YhCJ2
	w6LqOVZp3F2dIE//BqQj9OTAjnm/fuHrk09Nafhcuhh+bzXUrsurwRa922Jc9/sJu8Hif9jvYPN
	CljdPLsXAo6Y/RWaT1gZU7tMyzfN9gCWFmpECAEwj+wMCEMoqSzl5one0WX/u3oVw1ne95O0Xr+
	BFShSu3yKn3O68AUF/dsGoasooUd6HEme0=
X-Received: by 2002:a05:622a:1355:b0:4ff:c295:3c3e with SMTP id d75a77b69052e-502a15ebcadmr161649121cf.10.1768845807242;
        Mon, 19 Jan 2026 10:03:27 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1ed3155sm73886881cf.19.2026.01.19.10.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:03:26 -0800 (PST)
Date: Mon, 19 Jan 2026 13:03:10 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-security][kirkstone][PATCH 0/9] Assorted
 fixes
In-Reply-To: <188B0908E0CEB0C9.3218961@lists.yoctoproject.org>
Message-ID: <78c1d218-2ace-84ad-2ab4-564f7284bccc@konsulko.com>
References: <188B0908E0CEB0C9.3218961@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Jan 2026 18:03:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3013

On Thu, 15 Jan 2026, Scott Murray via lists.yoctoproject.org wrote:

> This patch series pulls together the couple of recent contributions
> to kirkstone branch with selected backported changes for known broken
> recipes plus getting the base CI build tests working.  These changes
> are on the kirkstone-next branch of meta-security, and my plan is to
> merge them to kirkstone tomorrow evening (EST) if there are no
> objections.

My apologies for the delay, it slipped my mind on Friday.  These changes
are now merged to kirkstone branch.

Scott


> Things to note:
> - The Parsec and musl build tests fail, and given the impending EOL
>   of kirkstone, debugging the failures is currently a low priority.
> - checksecurity and lynis have ended up with minor upgrades due to
>   the process of working through cherry-picking fixes from master.
>   I believe in both cases the upgrades are minor enough to not be an
>   issue, and that seems a small tradeoff for actually building now.
>   I would have considered being a bit more aggressive with updating
>   lynis, but it does not seem worthwhile given the impending kirkstone
>   EOL, and no one having complained about the recipe not building.
>
> Scott
>
>
> Changes:
>
> Armin Kuster (2):
>   chkrootkit: update SRC_URI
>   checksecurity: update to 2.0.16
>
> Marta Rybczynska (3):
>   CI: update build for new CI
>   kas: update configuration
>   checksecurity: update the debian package
>
> Scott Murray (2):
>   Update maintainers
>   meta-security-compliance: Update lynis
>
> Vijay Anusuri (2):
>   sssd: Fix for CVE-2025-11561
>   clamav: Fix for CVE-2024-20328
>
>  .gitlab-ci.yml                                |  49 +++---
>  README                                        |   4 +-
>  conf/distro/include/maintainers.inc           |  72 ++++-----
>  kas/kas-security-alt.yml                      |   4 +-
>  kas/kas-security-base.yml                     |  21 ++-
>  kas/kas-security-dm.yml                       |   2 +-
>  kas/kas-security-parsec.yml                   |   4 +-
>  kas/qemuarm64-musl.yml                        |   1 +
>  kas/qemux86-musl.yml                          |   1 +
>  kas/qemux86-test.yml                          |   4 +
>  meta-hardening/README                         |   4 +-
>  meta-integrity/README.md                      |   4 +-
>  meta-parsec/README.md                         |   1 -
>  .../lynis/{lynis_3.0.0.bb => lynis_3.0.9.bb}  |   6 +-
>  meta-tpm/README                               |   4 +-
>  meta-tpm/conf/distro/include/maintainers.inc  |  33 ++--
>  ...rity_2.0.15.bb => checksecurity_2.0.16.bb} |  17 +-
>  ...k-setuid-use-more-portable-find-args.patch |  16 +-
>  .../files/setuid-log-folder.patch             |  52 ------
>  recipes-scanners/clamav/clamav_0.104.0.bb     |   1 +
>  .../clamav/files/CVE-2024-20328.patch         | 153 ++++++++++++++++++
>  recipes-scanners/rootkits/chkrootkit_0.55.bb  |   2 +-
>  .../sssd/files/CVE-2025-11561.patch           |  50 ++++++
>  recipes-security/sssd/sssd_2.5.2.bb           |   1 +
>  24 files changed, 346 insertions(+), 160 deletions(-)
>  rename meta-security-compliance/recipes-auditors/lynis/{lynis_3.0.0.bb => lynis_3.0.9.bb} (84%)
>  rename recipes-scanners/checksecurity/{checksecurity_2.0.15.bb => checksecurity_2.0.16.bb} (57%)
>  delete mode 100644 recipes-scanners/checksecurity/files/setuid-log-folder.patch
>  create mode 100644 recipes-scanners/clamav/files/CVE-2024-20328.patch
>  create mode 100644 recipes-security/sssd/files/CVE-2025-11561.patch
>
>

