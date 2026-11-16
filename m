Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6301.1794870776408316459
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 16 Nov 2026 15:12:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=e+8Vftqd;
 spf=pass (domain: konsulko.com, ip: 209.85.222.45, mailfrom: scott.murray@konsulko.com)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-99bf7b97f12so221582241.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 15:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1794870775; x=1795475575; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n1PXFM5122XFA8wU6RuABqm/h6dYdyv9g6WY7+KVlcg=;
        b=e+8Vftqdj9UA/GkRwPd2at5rqwP93jBIH+xKzQ97+/NGL65m3JKj2Cp7OA2ToCf85w
         deCeA3rZxj5OK08XnnsZEiE/+aiPMdst2iVa+b2dRuGnbaQLTmWekB76UfWQ2Wo4EOKy
         rJvFl1+PAIleNTLtUMpkRhAPNnvBzNvK8b/mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870775; x=1795475575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=n1PXFM5122XFA8wU6RuABqm/h6dYdyv9g6WY7+KVlcg=;
        b=cMT42y6c+lxcOf2CDdMXsB0AGsowgmLB2LYHwVTfAHLZFe7RMvNpyqgQxzQzjva6xn
         oRrANS2JNKTzJjbC1QRqq6I/B21VINJrS5ovhqBdk8v3XrdOl9yX9rErdMnCWBi1og5s
         lEdpoa72fJE/3cUD4k7Uei6ZrIoeT4koO7A3UHtFOkxJ4thIniQUAB1+Ee9796rOH6yY
         tnInEICeeHDjqZQoW1TpUT3R51fAzWcbzfGUu7wXrkZCk8unFtv/j6SpABG4ueFaFUMC
         vNRKz/8BAMhzVhh+x0m7+Xgdnx3oSmGW58DbRXzTi92uOB87pjcRRx8JE5qsy2bu2YMt
         W5sg==
X-Gm-Message-State: APuU4Z9lY/zUefztBd9CF/pCSXMiX4eoXgSqYGfDCsVOlbjLaGLGkl64
	KCCavIHEFW79Zd06+uWaWQLAojy6CElhk9b6EuYIJyE/WhECVy6vkFyL0CuCvoYMAUf5nfF2YSZ
	bxp5U3Zg=
X-Gm-Gg: AYBFou3Rm7m4BC0D8m4w9J9blJ8ZwbzJEUscI9dwzOL8d61TOJOsVz4fHWFD38J1lCc
	CHSeMMt93EwNWeyVeaHRAb/LXdtyybeqOMplXFRN3titweC/5L2P9pg/igIk5X1VJXVI7ME/aMl
	qZGPTaJdpsLNXBBfM1Y+UCop2tJYJMORPld5qOYkbss7aiKdh15RXVNcuj+OUcNt7TBtR8Mue8v
	9cLHc+WYLomY1yATF+gNAFXO/niQ57RRj989+OzgugIk8I93/9CNELosjsWtEW9UO5CIaa2D/+e
	NgTV4usWshtVD4tvFKviLf00biL1Rf1xqkwM2ffAqtaU336/GYPWd0SrEXN4GgtT/D2ubVhW0Wm
	lbdZURY39LR3IfazQuBHl0wjlqFGd/MN+C3cRQ2pQMvuxyHOkMrezXgfTgJ1rF6P3Ognc9p1hS2
	v0GDtVSmlVBi3yW82/Cj54QvV2/EA/EJLQFGYSPcU7ryD3ORAE0s0SFj7N97S7QSJFjCYqbTOGb
	Lono4oYKHnqtNitfw7MbNTtD67gfkNVuJggt6JAZzWfpWZCN39Aip037zOhZB+w/a5gD2pfnsiq
	tcahB79GxylQSUQRvMn/flGK/ZSbHGIWuoBd73OWsLDYAdTP/wwJ5xgsXhuKYOO0fapf5RnZDKZ
	yoGKKYoHx9MOLNq1US3u9CV/367UzKT216pzFzeUl9lpG1fWKhOVLSOpIrEIsrhRY9J4=
X-Received: by 2002:a05:6102:644a:b0:7ce:645a:139e with SMTP id ada2fe7eead31-7d69f7d3540mr248463137.23.1794870774948;
        Mon, 16 Nov 2026 15:12:54 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34e9516dsm7575235e0c.12.2026.11.16.15.12.54
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:12:54 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][wrynose/rust][PATCH 03/19] cargo_common: map the cargo vendoring directory for the C compiler
Date: Mon, 16 Nov 2026 18:12:24 -0500
Message-ID: <509fb1941c0dd7de502ec175de1595cd22adcd51.1794870526.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794870526.git.scott.murray@konsulko.com>
References: <cover.1794870526.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Mon, 16 Nov 2026 23:13:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5441
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
index f58bd80..1478262 100644
--- a/classes-recipe/cargo_common.bbclass
+++ b/classes-recipe/cargo_common.bbclass
@@ -51,6 +51,11 @@ CARGO_TARGET_SUBDIR = "${RUST_HOST_SYS}/${BUILD_DIR}"
 # Where we download our registry and dependencies to
 export CARGO_HOME = "${UNPACKDIR}/cargo_home"
 
+# Crates that compile C or assembly sources do so through the cc crate, which
+# is not covered by the rustc specific RUST_DEBUG_REMAP, so map the vendoring
+# directory for the C compiler as well.
+DEBUG_PREFIX_MAP += "-ffile-prefix-map=${CARGO_HOME}=${TARGET_DBGSRC_DIR}"
+
 # Don't instruct cargo to use crates downloaded by bitbake. Some rust packages,
 # for example the rust compiler itself, come with their own vendored sources.
 # Specifying two [source.crates-io] will not work.
-- 
2.56.0

