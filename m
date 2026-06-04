Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B83CD6E4A
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 11:40:12 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9339.1780573207816843357
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 04:40:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DelWeX5V;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517760dc3c2so3470051cf.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 04:40:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780573207; cv=none;
        d=google.com; s=arc-20240605;
        b=KEr7RyyH6fENFnhdesR2HWcNSmD4FzE+ChY2KVJr7QRgjAIn/dEr2ukoZwMpuWSmvJ
         ioPmx1o4BC/8u7t7O0Ml2XpaKmLrJV6u1222Rr24/eDP/EMm9csOoelbEm7yBYjyO0E2
         KbKgF0gITC/h+QHVEAuA0ghSovXd9xgp+0HB2HE8qsxQLVVjrBSDuXaQ9a+r31vb7pf6
         1Uys7LbFhJY12vOfyVcmrLpb+wcQ4WJIq4+HUJqiS7z/Ak6szDhs+t0KD5PfqfRTfBjm
         yqqQFQmUhvEDbAYUFXp0gMkONYWl3KojsnDV99dQIpuKKYvnb6FzsOd1Z7AMsf4GBxBi
         4n5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JkreQJs8RtkqqNFXzcR2yMF9sZX49a0rEoiQjXQbQlI=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=ICRkGVB24Xq98T2LBHUPJjMNgt8EAIA57HaVO2wQRRQMeqjJ7BNbN2aATp3efoimex
         3w/IN7dgxn+IsZzrNzMEAZMDGohaXQm7b8Y1MtaGoxSB/cugVvwR5J9e/SWwxu0hlaOl
         g7xywHrzmw7FW1anPCg/S5zgvMRRjTqzlcp98MEaeB/UTwSpt+AqHj/KN4k4mQCJiqGB
         1XrQE33kt9t2L4SYV8IFCfba73zhmNX1DIFD2eTvR5qQPOoo+H8awvZmAODPumaQTvSF
         P/rWOuySERPAd+wI8mlga96plwYhSWxiL71cKNRHGvsVVMGlugIqZYvUErxDkNyD6VTu
         v64A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780573207; x=1781178007; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JkreQJs8RtkqqNFXzcR2yMF9sZX49a0rEoiQjXQbQlI=;
        b=DelWeX5V4d0vgLUgVb/oBfs6E1mO6tm0HXklqsWFrm5UHb5iH3nd7QU896lsZpcvHC
         U2sPMJuf+TSPFd5e5jpNRNpxVjBcO5ShL36lJSuwqYHsnePC/b8ZzLOK7E1zloULw5dE
         XRo5VYiXeI8S+unK3BxZWgpr0aXzJqTowhZyI8nQZR8/yu8Sg2uxANozPgHDJhQCQpcr
         zEX+T/AZrudtp51NCib/Dd+PAwqU8XqD77PzpF+Q2hJUwT+dNPCf2/87wWUsymJ/4hhr
         IfZk0UrytSjdwmuU4IgIta+zuo8NrpEV2SXPE4sy6eA9U5Q42DF3C5BhlKHmEVZ1xWdw
         kIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780573207; x=1781178007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkreQJs8RtkqqNFXzcR2yMF9sZX49a0rEoiQjXQbQlI=;
        b=DXE/VH+RqulCCGbwtaZGX9QC6cCJJPMBFKETuQFzfN5+Y46IK0B/GfrKJheDjYlxjA
         8HFEp0i0cwyi+ubKC9ei0asXTouMuxx6JcJIezhDuWfmZhx4w/76kpy4d8ot562gLktc
         Vd4/g7TZMMt6FD4MSlHvCet3+yi/ru108dC/NrMbf0Q6JKLelIka8jrI/kPew7Ctcpck
         c7onlKKp7uDJZ7ubjV7x0H8m44u8l3I65A/XCSL9RbmtUzCRUgPewqfqDANq+XSWUA51
         oqQC1uYqsVo9RTA+V4OSVzklmAG4ydW3IzLGLFf9GZ0PKwouyQEVmFacSJwG8SOlrABL
         juDg==
X-Gm-Message-State: AOJu0Yzk3T9RXSlhLHitro0pTzyWfHOzhIY5RzIL8r6nIVd5nITLBkwy
	cd209wa08w8FsDdjUU+CF2JBnzZhnbDw0PTzU7r25NFIssSnZVxxZB57oPbT7a/sbpZzVQa3NqD
	HiqyuNkxtiVZh8AUIot4xE+jFyctXBQY=
X-Gm-Gg: Acq92OHgcLECTFZNzPvfJmWqltpDcPFpbWlaBYDQ0ANU6UfWQzdof4pYju3JvaDH5dL
	u5jp0YmK33cIgLkUW+6R4f4X63hS8mRQhjmFKMcRZwE7XOQf05ArGa0v2ENRoyDOI19IlZUxSOp
	7YFGi5Er6E09U3tChylogB90IRBd9Znm2OdTN+zFnO9QoeK/LSLBsgJif9MmwP/JTO807xRmn7l
	jqUc8tNPCPhLTjpWB0rLPwmouNO0SeFUVH0C2oeRa5q379gLqOKQIXTkFgSf7KMzLqm1VSJ5jMe
	kcf4fScNzNj2NBoroaF8PbCFlvRhoET+s6jQuRd6HcY/cBVyI6vE
X-Received: by 2002:a05:622a:6091:b0:517:7620:20f9 with SMTP id
 d75a77b69052e-517785d8b28mr107810331cf.19.1780573206716; Thu, 04 Jun 2026
 04:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260603134044.3377639-1-daniel.turull@ericsson.com>
In-Reply-To: <20260603134044.3377639-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 4 Jun 2026 13:39:55 +0200
X-Gm-Features: AVVi8CcBnTCgVLLFMwf74QgwQh6CIELJWSWYYrLDYRavrdSwOv2wYr5wi33PvT0
Message-ID: <CANNYZj9X=Bd47XAP49w6hDqP6GVTMNWxE=Jc8WUV78bUdRCULg@mail.gmail.com>
Subject: Re: [AUH] [PATCH v2 1/2] upgrade-helper: add state module and
 --incremental mode
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 11:40:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4139

On Wed, 3 Jun 2026 at 17:50, <daniel.turull@ericsson.com> wrote:
> Behavior:
> - Failed attempts are retried after retry_interval days (default 30).
> - Successful/already-current upgrades are suppressed for success_max_age
>   days (default 30).

I have realized that we also need to handle recipes with rapid-fire
releases, that would otherwise flood the mailing list with daily
updates (if AUH is run once a day, which is the goal). This typically
happens when:
- there are no release tags, the recipe just takes the latest commit,
and upstream adds commits frequently (for example, vulkan-samples)
- upstream does have release tags, but they're added often, e.g.
sbom-cve-check-* items add them once a day, and some python items are
also rather quite 'liberal' with tags

So I'd suggest:

retry_interval is renamed to retry_same_version_interval
retry_any_version_interval setting is introduced
retry_any_version_recipes setting is introduced, and is a list of recipes
_prune() is adjusted to first check if a recipe is in that list, and
if so, it's checked against retry_any_version_interval, and not any
other intervals, so that it's guaranteed to be skipped until that
interval elapses (and skip_reason() should consider that similarly)

Otherwise, I think this is more or less ready!

Alex

