Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3149.1795645886466536677
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 25 Nov 2026 14:31:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rnkDZoeN;
 spf=pass (domain: konsulko.com, ip: 209.85.160.177, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55d846e884eso39198461cf.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795645885; x=1796250685; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cM2MxOyCv3++XVfBXeNljV0XrhZwzeASgbidYq7BxKk=;
        b=rnkDZoeNLQIuh2fV8EOAmiFionOt0dqct309+Y7oTSzSsZV3IW2NCFhG5D6KkQ6dgu
         cDG2pqsRmoa56ofgM4Z0lUvkHzw+9s0MQO0Go6XBp441bowSxYTd3erhTGmVntDHakdR
         EVYFgji0vDgExkVxWSTeHgsiyhcRf6/+2PnQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645885; x=1796250685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cM2MxOyCv3++XVfBXeNljV0XrhZwzeASgbidYq7BxKk=;
        b=gfC4Nlm31oUV731JyYoUptwhcmbCOS7m3RYHFthKxBN0pRPMadTLV72KtsnJykxwwx
         3mkspU89FxXviw6A9ZV2tY//FHIiIjh9MY9LkMPuZklVqnK+EYE8qhqjVUDqxR2m+eN5
         9V7AljIJ0z4hNdKyqZDHPjc3+/n/gs+TuW+wfNaattfgWXYJ16NzItM9kgP+AuWn3015
         qWOi1OLXzixk0Tt/L0fpml0Nmw+kkHGwAcaSw/MTyDicG5s0WRF7oWvRbzm70unB1jM5
         KmAv+DafXH38KutSTEVuTu7+GEyNg0hNpWeOPeWqTCJbbDZaVwxxq64S+wKZlDcpNRtC
         6IQg==
X-Gm-Message-State: APuU4Z+rlTz9Ckg/Hz0evIr5ljtEK9Z/ROnxtR36wQYxQxbke1cminy6
	Wvm+H/dw8l8dgZs2QHZUN2OnlH8h8dSHlPy/bwHQfFR3OmdXwzzH/Cz261P3BnbpPoFytouXqKB
	4005k
X-Gm-Gg: AZFdTZf8YVfioS1XPizlxl+lQPCNG2cpuYiYXM/1kP15tSC6xSX0TCPqwE4HZBSaoFG
	sS5J4ZfhvN6LS3fiQU8nWgvYq88sAwdw+t1ThF1eicBR4eNTiRCYJgXXeicFBndjrlx7SLEdIl1
	QRceKld2jb73DetG3IAAafdWulGrza1gcLSTgAiOvWBTr5b1Ki5FrWyc1+JX1PElLfkcSAWzVPa
	8uCH4kah4Fbi28UTlN3bz53JgqiKzPmU8DdVwJhfWoUOKAlsDqbUqyq81p4t7z0T86WDxH3dH+w
	nXjpDRNuQVUQ//n8Lm/I3/0Wk+71izDCJ6nZ2lcAMugb9yMId1D0ZGw5BOVMw5kugP1iV1EFuqS
	EJ2AjDUJrBwOsA1hzA+0GPns2IJFX2uIl+TMUZAzre/zUv7PpEWBqUXyceMUh8fTv9M1sgEcqnL
	KEXVh/oHr1jqIIIXR2yY9x3nHjs1cOZUPrPzl/1IJZ/nION9e1vqi047/MuWhioQy2jpI6ZxwKG
	p5S9Mk6p3lzBEII98sAPA4/irQHRKe+qGcvVcbVXPYEEi4Pi9z3skxJzT6Aa4f8xkbbhYE75zQD
	2FMi0Jb7VwxE/c03PerW85AKfxeXB7t3APHDesgQEtcRBL2KMFWmKeDEyCUZQ08YB4NnJWvM6Ft
	8elUx1aaTavzpFbLKz/51sd6l0VhNdDROVIXBRQYysqSkDvfTH8QQLIrTkwmMfPPEKQ==
X-Received: by 2002:ac8:5f83:0:b0:536:34db:e7c8 with SMTP id d75a77b69052e-55d76a5d53amr369992731cf.33.1795645885183;
        Wed, 25 Nov 2026 14:31:25 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm167717091cf.2.2026.11.25.14.31.24
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:31:24 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 03/19] cargo_common: map the cargo vendoring directory for the C compiler
Date: Wed, 25 Nov 2026 17:30:54 -0500
Message-ID: <e30d471850e99155f7702b0266917287f4148c4a.1795645656.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795645656.git.scott.murray@konsulko.com>
References: <cover.1795645656.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 25 Nov 2026 22:31:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5521
Content-Type: text/plain; charset="utf-8"

From: Markus Volk <f_l_k@t-online.de>

Crates that ship C or assembly sources, ring being a prominent one,
compile them through the cc crate rather than rustc. RUST_DEBUG_REMAP
only passes --remap-path-prefix to rustc, and DEBUG_PREFIX_MAP covers
S, B and the sysroots, so nothing rewrites the paths below CARGO_HOME.
The build directory of every vendored crate therefore ends up in the
debug symbols, which trips the buildpaths QA check and leaves recipes
working around it by dropping their -dbg package.

Add the vendoring directory to DEBUG_PREFIX_MAP so those objects are
remapped like the rest.

Tested on corei7-64 with yazi and eilmeldung, both of which had dropped
their -dbg package for this reason: after the change they package the
debug symbols with no reference to the build tree left.

AI-Generated: Uses Claude Code (Claude Opus 5)
Signed-off-by: Markus Volk <f_l_k@t-online.de>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
(adapted from oe-core commit fd245ac1c2dfa2de2dad96b7db2a0201bc5c25d4)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/cargo_common.bbclass | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/classes-recipe/cargo_common.bbclass b/classes-recipe/cargo_common.bbclass
index 5bf9dc5..885994a 100644
--- a/classes-recipe/cargo_common.bbclass
+++ b/classes-recipe/cargo_common.bbclass
@@ -51,6 +51,11 @@ CARGO_TARGET_SUBDIR = "${RUST_HOST_SYS}/${BUILD_DIR}"
 # Where we download our registry and dependencies to
 export CARGO_HOME = "${WORKDIR}/cargo_home"
 
+# Crates that compile C or assembly sources do so through the cc crate, which
+# is not covered by the rustc specific RUST_DEBUG_REMAP, so map the vendoring
+# directory for the C compiler as well.
+DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
+
 # Don't instruct cargo to use crates downloaded by bitbake. Some rust packages,
 # for example the rust compiler itself, come with their own vendored sources.
 # Specifying two [source.crates-io] will not work.
-- 
2.56.1

