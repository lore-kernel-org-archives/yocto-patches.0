Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415EAC53219
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 01:41:17 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2413.1785202874579063456
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Jul 2026 18:41:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=S0PwwNxE;
 spf=pass (domain: gmail.com, ip: 209.85.210.172, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso3387163b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Jul 2026 18:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785202874; x=1785807674; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I+hnn95L4cDKZ1GORJfB2dNM9k/GnF6TMABlolZ9Kfo=;
        b=S0PwwNxEljlVCsR0Oiz8b46/hR5NPBk45ef/AdMEQxT3Hua8c0bAo9Tif26eFlKrsi
         XWbL/7kCgCCQxbsaGxJPFRJ/Cph8oDrEMXJEzd+B0uh/ivR7E7KzVBLea+z9uTdjOKT6
         dpDs/FGmzONG+E8Opu7+begqu209lnXbbRgW1xlnoNNj+ALPDaTxvcYeSx0nc2j5U5Zp
         AzEESulJB7D9SOij9xoJeZtdx51sR1+qGjT3Pjgoa3bxrne1ENLkgncsH1Ckjhs6v3Cc
         zAxh34qxaU8Wh9fjz8JNU1ZuNdZWWIqmBpK7RMyRzFNAmTIDxubjW/1Ta1fcgFWtjeFq
         QgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785202874; x=1785807674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=I+hnn95L4cDKZ1GORJfB2dNM9k/GnF6TMABlolZ9Kfo=;
        b=b2txwlZYs8XDGXwfC3QsR3tXVTaE+7eN2ok62pam6QLKJ/0VpqD6QNIJRwfJi4JsFg
         oodqL3iHaxjVeJM35NcbBfJ6bmSAPCepwxfVt8qP//oewaXoZY/73msR25GWUPrYvvWy
         Dt1dii7RHcPmFqhshK7tOHAS5j5F1OPxzyD89E7jZY165MQ8+Aua+0OrBThIf7e75Qxq
         zwUfuc6fdwek/PF1V7ss/QqCf2SCAKsmLa8tGLbZyXJnE5KPDn94L0T3w4GjlnAvUCt1
         nTDWgYgwJ3UdzFAmaMtkm77/OaqouMCSU3mRtBynfIQiLtH0CTwrg3F0x985hTy6nTUq
         nwYA==
X-Gm-Message-State: AOJu0YztEqEmv/paTCVfpIL6yQemOQpDCqjvBwhmCB1ZNggwPbnwwpgi
	9x9/nXtPUcIWggCa9w7YWgeXSjOoO+a/jRa8PYynNzm1BDELRAA6xoWVE86xIQ==
X-Gm-Gg: AR+sD100rYF/yQa2nBtB+o+UAx3VJHOjaRIXowIxHKxvtkobGNx0OHJPggRMflHSujK
	38FcKUpSc3wCx4mvsp4AeZKQ/UmIK+5e/EpxvTgC8jSpuI+aJbDufCqS1SF8FyNa5zOABCstypT
	BJzOOjzM6JG2N+WSXS1yc8z23go/rEtsvDevap7xdd+2fa2iVLUoI7uVlC0NFNlhESYXmSwTFLq
	tnlDLKRQRIwYap96czY7+bcbAPTgXglAupMoXivSO6L/vgBc88hK7TZjaBOO9xIh+vsgx7OxPXB
	+v50KEpc/iXpTYB3S6obWIvd3i1jl7FJCSJcHLdLB53RTw+dV4pWkXyb+ecjzFGBsyNtgsT0Wty
	V2VrXAQ0Pdy2fq79zJMEHLXgr56QpRAbaJXqTAMNnIZK66bQZ+ar8aHPgicqoIUICaJsd13RBbf
	cvmnTokLtCeILTq+5m+5b4K2ZPbW2EMK95lM+I/S28OiGVO2XdpW7N+EM1tGAnH6KTgbI4tgkSr
	DyqWtQEBdZE
X-Received: by 2002:a05:6a00:14ca:b0:847:973b:3d04 with SMTP id d2e1a72fcca58-84e93197cacmr326200b3a.10.1785202873516;
        Mon, 27 Jul 2026 18:41:13 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5344e577sm3661537b3a.58.2026.07.27.18.41.11
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 18:41:11 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v5 00/12] Implement 'containers' jobs
Date: Mon, 27 Jul 2026 18:40:33 -0700
Message-ID: <cover.1785198322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1783371914.git.tim.orling@konsulko.com>
References: <cover.1783371914.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 28 Jul 2026 01:41:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4539

This series builds on top of the patches already merged from v2 and
previously submitted as v3 and v4.

This series contains the 'yocto-autobuilder-helper' patches to enable:
* building, testing and publishing of 'vcontainer-tarball'
  - vcontainer-tests job
* building and pushing containers from:
  - meta-virtualization
* containers are pushed when the push_containers boolean is set in the
  AutoBuilder UI
  - regstries are set with CONTAINER_REGISTRIES variable
* authentication uses local user credentials (e.g. ~/.docker/config.json
  or .../auth.json for podman)
* containers are tagged with PV_MAJOR, PV_MAJOR.PV_MINOR, DISTRO_CODENAME
  and yocto-x.y release (yocto-x.y.z for release builds).
* multiarch containers built for x86-64 and aarch64
* signing of containers
* attaching SPDX 3.0 SBOM attestation (and signing it) for pushed
  containers
* 'dev' mode containers which run as 'root' user and in some cases add a
  shell. These are tagged as above but with a '-dev' suffix.

Additional features, such as attaching SLSA provenance attestations will
come in a future series.

Concerns about the possible infinite loop around the tarball extraction
"while True, try, expect OSError" code [1] are addressed separately [2],
since the original patch has been merged.

This series relies on the resolution of [3] for the vcontainer-tests to
be more reliable.

This series was built on the Yocto Project AB in [4][5][6].

[1] https://lore.kernel.org/yocto-patches/02f0c35f16a8a51bbe0e89145353008f67180a84.camel@pbarker.dev/
[2] https://lore.kernel.org/yocto-patches/20260606011918.61582-1-tim.orling@konsulko.com/
[3] https://lore.kernel.org/yocto-meta-virtualization/cover.1785110917.git.tim.orling@konsulko.com/
[4] vcontainer-tarball: https://autobuilder.yoctoproject.org/valkyrie/#/builders/116/builds/11
[5] vcontainer-tests: https://autobuilder.yoctoproject.org/valkyrie/#/builders/118/builds/12
[6] containers-library: https://autobuilder.yoctoproject.org/valkyrie/#/builders/117/builds/27


Changes in v2:
* Simplify by merging vdkr-tests and vpdmn-tests into vcontainer-tests
* Simplify by building containers from meta-virtualization:
- Depends on resolution of: https://lists.yoctoproject.org/g/meta-virtualization/message/9826
* Workaround for recent (since Friday May 29, 2026) errors:
  Error: reading blob sha256:<hash>: file integrity checksum failed for
  "<file>"
  - This is probably related to either sstate changes or recent changes
    in vcontainer-common...

Changes in v3:
* vcontainer-tarball is installed in jobs that set "vcontainer" similar
  to "extratools", instead of the more global "buildtools" behavior.
* The (rather large amount of) code for pushing containers in run-config
  is broken out into a dedicated run-push-containers script.
* Workaround for pushing containers is moved to run-push-containers. The
  most recent behavior (on top of meta-virt master-next) showed a
  different error pattern:
  Error: reading blob sha256:<hash>: EOF
  The workaround simply removes all container images from the VM's
  container-registry before importing or pushing new container images.
  The commit message was reworded accordingly.
* Rather than installing latest versions of pip, setuptools and wheel,
  silence the pip warning with PIP_DISABLE_PIP_VERSION_CHECK=1
* Rather than installing the latest versions of pytest, pytest-timeout
  and pexpect, install from meta-virtualization/tests/requirements.txt.
* Refactor run-vcontainer-tests script to use optargs instead of a mix of
  positional args and env vars.

Changes in v4:
* Adjusted the 'vcontainer' installation of the vcontainer-tarball to
  only apply to 'push-containers' step, as we currently only need the
  functionality to 'vimport' and push single-arch containers.
* Added app-container-alpine as a single-arch container example
* Switched other container builds to multi-arch, building both x86-64 and
  aarch64 flavors
* Added conditional signing of containers in the run-push-containers
  script, this is gated by CONTAINER_COSIGN_KEY being set to the path to
  a 'cosign' private key.
* Added conditional attachment of SPDX 3.0 SBOM attestation (when
  CONTAINER_COSIGN_KEY is defined).
* Added conditional verification of the SPDX 3.0 SBOM attestation, which
  is gated by CONTAINER_COSIGN_PUB being set to the path to a 'cosign'
  public key.
* Added building of '-dev' mode containers, with PACKAGECONFIG 'dev',
  which run as 'root' user instead of the 'nonroot' user and in some
  cases conditionally add a shell (depends on the container image recipe).
* Added pushing of '-dev'containers adding a '-dev' suffix to the tags.

Changes in v5:
* containers-library: Drop alpine single-arch container as we do not
  want to imply that building Yocto Project packages on top of alpine is
  officially supported. This does mean the single-arch workflow is no
  longer being utilized, but a more appropriate single-arch container can
  be added later.
* Remove NO_BUILDTOOLS = "1" from vcontainer-tests job as we need
  python 3.10+ for pytest 9.x (and buildtools works alongside the
  vcontainer-tarball).
* Add VCONTAINER_TARBALL_URL as path to the latest built vcontainer-
  tarball until some future date when we decide if we want to use
  a release build. This will be used for future run-time container
  tests or future pushing of single-arch containers.
* The container recipe series has been merged in meta-virtualization:
  8e33959d container-nonroot-user: document + assert inherit order vs image-oci
  6d464f78 app-container-mosquitto: fix PACKAGECONFIG 'dev' comment
  8fe9331f app-container-valkey: drop redundant OCI_IMAGE_RUNTIME_UID
  faf960ab vcontainer-tarball: fix buildbot-venv shadowing
  ce767999 container-image-multiarch: add helper recipe
  be1eafbf app-container-curl: use multilayer mode; container-nonroot-user
  712f9695 vcontainer-bbmask.inc: allow meta-webserver/recipes-httpd/nginx
  5af4f1cb recipes-containers/images: add app-container-nginx
  24d5e836 recipes-containers/images: add app-container-valkey
  0d277995 vcontainer-bbmask.inc: allow 'mosquitto', 'libwebsockets'
  a3190a33 recipes-containers/images: add app-container-mosquitto
  b525f916 recipes-containers/images: add app-container-python
  09e92d14 classes: add container-dev-mode.bbclass
  f03ae95e classes: add container-volatile-fixup.bbclass
  a250220d classes: add container-nonroot-user.bbclass
  fdbc054d image-oci: set OCI_IMAGE_RUNTIME_UID with ??=

Tim Orling (12):
  scripts: add vcontainer-tarball setup, integration, and publishing
  config.json: add vcontainer-tarball build target
  scripts: add run-vcontainer-tests for meta-virtualization
  scripts: add container registry push, auth, tagging, runtime selection
  config.json: add 'containers-library' build job
  scripts/run-push-containers: push multiarch containers with
    skopeo-native
  containers-library: switch to multiarch
  run-push-containers: conditionally sign pushed containers with cosign
  scripts/run-push-containers: add SPDX SBOM attestation
  config.json: add -dev container builds to containers-library
  run-push-containers: optionally push -dev tagged containers
  config.json: set  VCONTAINER_TARBALL_URL

 config.json                  | 161 ++++++++++++
 scripts/publish-artefacts    |   5 +
 scripts/run-config           |  19 ++
 scripts/run-push-containers  | 471 +++++++++++++++++++++++++++++++++++
 scripts/run-vcontainer-tests | 212 ++++++++++++++++
 scripts/utils.py             |  20 +-
 6 files changed, 884 insertions(+), 4 deletions(-)
 create mode 100755 scripts/run-push-containers
 create mode 100755 scripts/run-vcontainer-tests

-- 
2.55.0


