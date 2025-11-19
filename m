Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7FACF34C9
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 15:05:47 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9140.1763564745214009506
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 19 Nov 2025 07:05:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=ORiH6s6u;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-256628-20251119150541343ea818fb0002077c-5pdkej@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251119150541343ea818fb0002077c
        for <yocto-patches@lists.yoctoproject.org>;
        Wed, 19 Nov 2025 16:05:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=20WnD4DiFc07Phra5+VoX/Xd1EBA/Fui1ILGPmFW3Jw=;
 b=ORiH6s6utliu0VhYa+ujMsoYk1I6W1x0IGiyrBtgERusHe9uqKhPmweUJIsjU+B0hVcKm0
 OlefapNvA5rfTNif0MD4qlfTecdl+38r5hqsv02HHBkCmWn4ajXz+dwhPP3SKjUiNZY7cW9d
 ogkvdCq8YsV8GH6Gdrffh85kE5rRK7T/bfKUPWm56Bhp3QaeqbCBijCz+C5Ld6cpE9EywDTp
 ZQ7gZnslVaDK2zgVI0ra2WPnc+Uyr2pSeewHC6aIbtnQrRvzklV/hdsx7n5xHB/N9vwmNCZy
 Fr4BfieA5Ik9+q0CcZ0c/C7S4piitORnj4BaNgTDfAGR9nYdzvPT2pWQ==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][PATCH v2 00/35] initial scarthgap/go version
Date: Wed, 19 Nov 2025 16:04:47 +0100
Message-Id: <20251119150522.15477-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 19 Nov 2025 15:05:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2584

first version (RFC) coverletter: https://lists.yoctoproject.org/g/yocto-patches/message/2515

Changes in v2:
* updated commit message in QA readme update (showing single PASSED instead of 3 lines to search for)
* fixed release information in README (kirkstone -> scarthgap)
* update commit message of previously only submitted to now really backported commit (go-helloworld: fix license)
* fixed branch name in README (scarthgap/rust -> scarthgap/go)
* added 1.25.4 go recipe upgrade commit

Alexander Kanavin (4):
  go-helloworld: update to latest revision
  go-helloworld: update to latest revision
  go-helloworld: update to latest revision
  meta: remove consecutive blank lines

Gyorgy Sarvari (1):
  go-helloworld: update to latest revision

Hongxu Jia (4):
  go: upgrade 1.22.12 -> 1.24.0
  go: fix buildpath issue for go-runtime
  go: remove support for GOROOT_FINAL
  tcmode-default: bump GOVERSION to 1.24.0

Jose Quaresma (1):
  Revert "go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX"

Khem Raj (1):
  go-cross: Disable build with ccache

Osama Abdelkader (1):
  go-cross-canadian: fix binaries install and GOARCH

Peter Marko (19):
  Initial commit: add license, readme and layer config
  go-helloworld: add from openembedded-core scarthgap
  go: add from openembedded-core scarthgap
  go-helloworld: fix license
  go: upgrade 1.24.0 -> 1.24.1
  go: upgrade 1.24.1 -> 1.24.2
  go: upgrade 1.24.2 -> 1.24.3
  go: upgrade 1.24.3 -> 1.24.4
  go: set status of CVE-2024-3566
  go: upgrade 1.24.4 -> 1.24.5
  go: upgrade 1.24.5 -> 1.24.6
  go: upgrade 1.24.6 -> 1.25.0
  conf/layer: switch to golang 1.25
  go: upgrade 1.25.0 -> 1.25.1
  go: upgrade 1.25.1 -> 1.25.2
  go: upgrade 1.25.2 -> 1.25.3
  go: upgrade 1.25.3 -> 1.25.4
  readme: update to markdown format
  readme: add QA chapter

Randolph Sapp (1):
  go: fix sigaction usage on i386 platforms

Richard Purdie (3):
  go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX
  meta/meta-selftest: Fix variable assignment whitespace
  go: Fix to work without gold on aarch64


