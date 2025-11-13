Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ED2CD6E7D
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 12:57:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23163.1763038637499928743
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 13 Nov 2025 04:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=peter.marko@siemens.com header.s=fm1 header.b=W0VSmXuF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-256628-2025111312571422a9aa8838000207f9-ckjktl@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025111312571422a9aa8838000207f9
        for <yocto-patches@lists.yoctoproject.org>;
        Thu, 13 Nov 2025 13:57:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=peter.marko@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=lR2JSf2nOpFn398SnD0NknaHJwqcw3GMClrleGfDsCg=;
 b=W0VSmXuFwyQejKvBxp2fIRJcJtm76xvKCOYtwIqDt4SwVkyvD9R7qmsePicgCVEH2Rs1Qg
 Ft6GeU5oAIt2KPFAUwNz91W2JI0qdMso3KyzctIimRoq65XyF6CKvj5iHL7vyrXpBTRRc0+5
 +1F9IwN7w/zq1noXUDpb8/4Tu3U2InWT5zSa7BHBRGWC3NfgFksimE7dpj7qMyLIX9pEBAip
 g4hQMe9Zb8ss8V6R2gFiBc/qsr+sXb9HTY5tDa83vD73oFTPEZ8hR8KDuN3piD3nxWqpMbGu
 3jzHuaaN3ir7nGCy3299oX30bE/m4Sbfgb4p2isDdYlCvejQE2u1NB5g==;
From: Peter Marko <peter.marko@siemens.com>
To: yocto-patches@lists.yoctoproject.org
Cc: peter.marko@siemens.com,
	jose.quaresma@foundries.io
Subject: [meta-lts-mixins][scarthgap/go][RFC PATCH 00/34] initial scarthgap/go version
Date: Thu, 13 Nov 2025 13:56:38 +0100
Message-Id: <20251113125712.18914-1-peter.marko@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-256628:519-21489:flowmailer
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 13 Nov 2025 12:57:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2515

Hello everyone,

here is initial draft of meta-lts-mixins scarthgap/go branch.
Compared to kirkstone/go this now also contains proper testing.
Functionality is I think equivalent to current kirsktone/go branch.

Note that the testing depends on not-yet-merged series
  https://lists.openembedded.org/g/openembedded-core/message/226238

Creation notes:
* base commit copied from kirkstone/go branch
  * adapted release name and removed obsolete lines from layer.conf
* all recipe changes from master were picked into this series except those not suitable for scarthgap
  * 7321cc17ae5483f17fe9cdffea7b62acd9d9c3a2 meta: set S to be in UNPACKDIR in recipes that explicitly set
  * 4ccc3bc8266c327bcc18c9a3faf7536210dfb9f0 classes/recipes: Switch virtual/XXX-gcc to virtual/cross-cc (and c++/binutils)
* all test changes from master were submitted as backports to openembedded-core (link above)
* 3 patches were sent to openembedded master branch upstream based on testing and file comparison
  * https://lists.openembedded.org/g/openembedded-core/message/226226 oeqa: fix package detection in go sdk tests
  * https://lists.openembedded.org/g/openembedded-core/message/226231 go-helloworld: fix license
  * https://lists.openembedded.org/g/openembedded-core/message/226237 oeqa: drop unnecessary dependency from go runtime tests
* class/lib changes between scarthgap and master are following:
  * $ git log --oneline 8f46f60a703defc3e74adad382320c129cef0b06..origin/master -- \
        meta/classes/go-vendor.bbclass meta/classes-recipe/go.bbclass \
        meta/classes-recipe/goarch.bbclass meta/classes-recipe/go-mod.bbclass \
        meta/classes-recipe/go-ptest.bbclass meta/classes-recipe/go-mod-update-modules.bbclass
    26368cfb91 go-mod-update-modules.bbclass: Update license finding
    cfff8e9682 goarch.bbclass: do not leak TUNE_FEATURES into crosssdk task signatures
    0aa406d058 recipetool/create_go: proxy module fetching to go-mod-update-modules
    34bb889ffa classes/go-mod-update-modules: add class to generate module list
    5f8218c626 go-mod.bbclass: Calculate GO_MOD_CACHE_DIR relative to ${UNPACKDIR}
    374a91204b go: Check if GO_IMPORT is set in recipe and error if not
    791ab77ac0 go: remove support for GOROOT_FINAL
    30ea609d33 meta/meta-selftest: Fix variable assignment whitespace
    6c4e3206b6 classes: go-vendor: Change symlink creation.
    fc4f589cc7 go-vendor: Fix absolute paths issue
    114fe16f96 classes/go-vendor: Use UNPACKDIR instead of WORKDIR
    35496654db go-mod.bbclass: Unpack module dependency license files
    287daff0bb go-mod.bbclass: Set GO_MOD_CACHE_DIR
    cc4ec43a2b go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX
  * there are mostly changes to directory layout, fetching and style or new go-mod-update-modules class
  * GOROOT_FINAL can be kept as unused variable like in scarthgap
  * TUNE_FEATURES fix is being backported to scarthgap and kirkstone opembedded-core

Peter

---

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

Peter Marko (18):
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
  readme: update to markdown format
  readme: add QA chapter

Randolph Sapp (1):
  go: fix sigaction usage on i386 platforms

Richard Purdie (3):
  go: Drop fork of unpack code, mandate GO_SRCURI_DESTSUFFIX
  meta/meta-selftest: Fix variable assignment whitespace
  go: Fix to work without gold on aarch64


