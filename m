Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56B8E784BE
	for <webhook@archiver.kernel.org>; Thu, 25 Dec 2025 02:51:17 +0000 (UTC)
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.132894.1766631072473493226
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 24 Dec 2025 18:51:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=opeJHyWZ;
 spf=pass (domain: konsulko.com, ip: 209.85.219.68, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-88a3d2f3299so74628466d6.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 24 Dec 2025 18:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1766631071; x=1767235871; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WuL4LFNgBygGx1/Km9YtAzwSnaM2gbLnAxWQuselOh4=;
        b=opeJHyWZZaAFz2pXIcr7itUa3gfaUXrh9upweQmojA6ENGv79GjeA9G0lJnienUdpc
         SvnRYuiFIEO1qbfMA/Scn3wFmgFHP5Bei1NLrj+eAVO3PVhB5cR7U6QzaLrx+zcEWTo5
         WHD9oaqVPqgtEetDArCHMVMQYAvLJsgADApiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766631071; x=1767235871;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuL4LFNgBygGx1/Km9YtAzwSnaM2gbLnAxWQuselOh4=;
        b=oxYnEpTserW/mfAkczFiv2/3OUFFp7qVbrHO295+XPCC13z0fYm1KRLikDH/d+Vhra
         fyYRsntyjvFVuwQXMYUQLOIznYUwZYJF0UhRpssrkb1fIiqBv3FkOuvW7sfuWjp1u1KZ
         af+Qhw0w1K//XdJICCjzP4Ie040duif5WVajybQaJ/r2Km/oR9VCcNCojr7ksNY98H4w
         k2/nZyLd5PBBc26gchNDClYWf2X06BNfx3VeBr1LF2KzGhTNZPIl7XYm6s3SqY3ACiRu
         5zay15NuqUoCaeD0JzFm0WNv3nBJCeNh8Ea8VZkizZX1nSBRNsq+PYAwL/CHnucsZHEd
         xzXg==
X-Gm-Message-State: AOJu0YyZ1eCGDKqxauPHhJkaW6om6CttPXAlyTbyzm6/oJI0hdinhCuo
	71prT6i5/6HlzynI9KMNKxGJkW9tIB9N9qxKgFA6X0qz8tiREgfPCpSqFU9mPcvt8XWxTX/sBp1
	zHDYwPPk=
X-Gm-Gg: AY/fxX6S5VcysZctuBXIyLkVyRnrdogYt77A5p1QwaPL1pCElIixu5K++NzHZYxnvHc
	9k4DZDr2wY1SXqF8CL9Ted/qdz4feVdkob17ZfOQPmZcpaToBW+k4uSqrYt6WADzzLh1ev5TDUV
	/RdX28dMVHN3Uobkuf2gS6CqVy8Q7j8qJ0flDI7vZBU6zisfeHOi8ccbWJo3oMNTAUxQ+HXITEY
	oeu4jrsq5HxdzW6CIqwFYBgP5hid9JlIZgg//IDECN3h0gl/6V5pkT82Bs+dMMakO0Z5drz72F6
	EcAmBqirDDALNEV0rzFbhNGu8ejDvNyqhIy1XrIdDKpmo78Pi91EZvXUDBPC9+TCOiCEWkdIn5e
	KeyEfYcayevIYv69w87mpI1z3NSmzYVuTk4/QSWUdXlt23m6A9zJBlXbjiXV50rp5lLAAhUvmWC
	9dw2cfVyKedn7jQVbAV+o7uZq8FJF5iNm1GfchTfnNHqRJmCpkEHj1mcESmxEIU9PisknlztSNb
	GbDsSLbJ+RFbbc/sAjpPp4rz8C90x95XuI=
X-Google-Smtp-Source: AGHT+IFYilL60C4fCL4wVUukNPN00Z2ExF2Vddd2h4M8p07nvW8RQYIaFkJ7hrh9mYqwgAXSMGpaPA==
X-Received: by 2002:a05:6214:5d06:b0:88a:4391:59d4 with SMTP id 6a1803df08f44-88d86961f7bmr259702676d6.51.1766631071183;
        Wed, 24 Dec 2025 18:51:11 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac64a47esm137139081cf.24.2025.12.24.18.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 18:51:10 -0800 (PST)
Date: Wed, 24 Dec 2025 21:50:53 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: Marta Rybczynska <rybczynska@gmail.com>
Subject: Re: [yocto-patches] [meta-security][PATCH 0/8] Assorted updates
 12/22
In-Reply-To: <188397C2518E0B00.1342979@lists.yoctoproject.org>
Message-ID: <6cb8cae3-36f1-e657-4ef3-bede1ae0c6a8@konsulko.com>
References: <188397C2518E0B00.1342979@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 25 Dec 2025 02:51:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2872

On Mon, 22 Dec 2025, Scott Murray via lists.yoctoproject.org wrote:

> This patch series rolls up the contributed patches from the past few weeks,
> a bump of suricata to 7.0.13 that I worked up, and after a bit of rework
> to get it passing CI the contributed update of clamav to 1.4.3.  Note that
> I had to disable building clamav on all 32-bit platforms due to what appears
> to be an upstream limitation/bug.  If you need it on a 32-bit platform,
> I'm open to carrying a patch, but a fix would ideally come via working with
> upstream.
>
> These changes are queued on the master-next branch if you would like to
> check them out to test yourself.  I intend to merge these to master branch
> at end of day tomorrow (Eastern Time, Dec. 23rd) unless there are objections.
> I also plan to create the whinlatter branch at the same time to get that
> going.  For scarthgap branch, I plan to look into backports of newer suricata
> and clamav in the next week, but we'll have to see how that goes with older
> Rust.

Sorry for the delay, these are now merged to master branch.  I'll push the
whinlatter branch when I get the chance to get the CI configuration for it
tested.  Happy Holidays!

Scott


> Changes:
>
> Clayton Casciato (1):
>   suricata: drop deprecated nss, nspr PACKAGECONFIGs
>
> Hemant Jadhav (1):
>   clamav: Add recipe for version 1.4.3
>
> Scott Murray (2):
>   suricata: update to 7.0.13
>   scap-security-guide: update branch
>
> Yi Zhao (3):
>   libmhash: add UPSTREAM_CHECK_URI
>   sssd: inherit github-releases class
>   scap-security-guide: add UPSTREAM_CHECK_GITTAGREGEX
>
> hongxu (1):
>   openscap: switch to libpcre2
>
>  .../recipes-security/sssd/sssd_2.10.2.bb      |    4 +-
>  recipes-compliance/openscap/openscap_1.4.2.bb |    4 +-
>  .../scap-security-guide_0.1.78.bb             |    3 +-
>  .../packagegroup-core-security.bb             |    6 +-
>  recipes-ids/suricata/suricata-crates.inc      | 1437 +++++++++--------
>  ...{suricata_7.0.12.bb => suricata_7.0.13.bb} |    6 +-
>  recipes-scanners/clamav/clamav-crates.inc     |  286 ++++
>  recipes-scanners/clamav/clamav-git-crates.inc |    9 +
>  recipes-scanners/clamav/clamav_0.104.4.bb     |  156 --
>  recipes-scanners/clamav/clamav_1.4.3.bb       |  236 +++
>  .../clamav/files/headers_fixup.patch          |   58 -
>  .../clamav/files/oe_cmake_fixup.patch         |   39 -
>  recipes-scanners/clamav/files/tmpfiles.clamav |    1 +
>  .../clamav/files/volatiles.03_clamav          |    1 +
>  recipes-security/libmhash/libmhash_0.9.9.9.bb |    2 +
>  15 files changed, 1279 insertions(+), 969 deletions(-)
>  rename recipes-ids/suricata/{suricata_7.0.12.bb => suricata_7.0.13.bb} (94%)
>  create mode 100644 recipes-scanners/clamav/clamav-crates.inc
>  create mode 100644 recipes-scanners/clamav/clamav-git-crates.inc
>  delete mode 100644 recipes-scanners/clamav/clamav_0.104.4.bb
>  create mode 100644 recipes-scanners/clamav/clamav_1.4.3.bb
>  delete mode 100644 recipes-scanners/clamav/files/headers_fixup.patch
>  delete mode 100644 recipes-scanners/clamav/files/oe_cmake_fixup.patch
>
>

