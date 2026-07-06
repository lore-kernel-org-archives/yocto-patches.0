Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6351C43458
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 22:06:34 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.161471.1783375593647074625
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 06 Jul 2026 15:06:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EtHCMmx2;
 spf=pass (domain: gmail.com, ip: 209.85.210.181, mailfrom: ticotimo@gmail.com)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84347ad88edso4792664b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 15:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783375593; x=1783980393; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2tqtdqgjyxeZ2Xml9QwM/ftuUTAZCivCLjUhK82jcZE=;
        b=EtHCMmx2E0VSV7IkPFHlJOTsNJ9LmDCtNlW9D4t3hI9EQUIIyZffxm6zlAxs3xYXGw
         Bps5TPq2pafAgH14ZZOgIPG1qXcoJb+M+EpH8Ksl+CsLBOtk3zcRXh7zkglle9cviLh2
         WEwFJwdM+9v2ADy8bQJ/nbBhUndTXzv12aHyUQp+2WOtJQK+5nHh100OFBATX8LhRcZH
         wFjv54CC09IYhGyI46lSDzBJVBgrWiweCbZKLOltpYeKHWyQUg2cgBzxxPdtmz4F2eAx
         YUPdapyfSqYZM13x48zf0hjoFgPWsJZmWC12G1bbi2IKsZVO7jDF435AncYf0/pKvbdO
         b5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783375593; x=1783980393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2tqtdqgjyxeZ2Xml9QwM/ftuUTAZCivCLjUhK82jcZE=;
        b=kKXZ2c9Xtf0a9cfZ+HfO/hY8d0wW6hQUBUaO+VteetC9f0VThNggD779vKlbxyOzo0
         1ZEumrcaGBnDSBJcWdImQcrV5le8/O5h8GMmUh+sPTAXYy1rsVHdrnwkUSgdF7YqBi2U
         9fZE/2dqdzvOD5DX4zRpmLCk89BQMBWKkxhXy2dYDeJYnHoT4jaOBDXmOuoX+dAbbxVK
         16lvtZ6BHL+Gi8ewphHZUfs6TJ74ZaDUU+Qg2fhNNqbwcAfYffpzgXzBim8ryVe9U6ct
         5twjPiRnymuq8FnYrKTT2hdtewQZd2n9lbSTR+br+oRY9I7uDpCVMt+t+/Rcu5JzakJ/
         Rabw==
X-Gm-Message-State: AOJu0YwgRdVqIAPPKt9TuYoz1TZVBighZhW3D108TeFcWy2HFD8w3Ldv
	NFF2YIuALSkLiwJU3US2Jhgv4jNzV5fQwZ3vkAYZ0ORh5lpybIdZJ/DIAusG7A==
X-Gm-Gg: AfdE7cmBZHxbNJACEwm3/0MMkNDrP38laKNbHFJqthVx53la9WYjDvJiCa5kkpM5yRP
	JUO0retVmoZqxGPjsJnbH68J6y9tGHkNpPpW4AjV1M3IbyFnv1DCyivcMp0kGpmT+T5dEVQNuqk
	hRFlEQW7SVrIZBjiB0rT+Cu0XI10CBtN5iMYjWfvN1bm8jZvDBOe0nbyFy+oeUe98fYiqGBcPOX
	rwN7ejfgjqCAveSMSy7BhI4XwyDqGpNxxED1qpNQdSrgVQH7EXJAgbjzyQgtl8DhTxX6ztwa/pd
	ik++A5CNGRZmmJykHgR4ZISwhw5XJivWgATlGHbVaAi9/j9azX7WEDuc4h1cA7wYFasDKVNXKJZ
	TkoOslQa8CE60pLUaqa/zXcsNQl6CoKi4RcyC64UyAKfcKgKufW8sxH2/li5NenAFamflqp5Cs3
	DZ8ritSZ14fYJoYgvEVyIrpBkobv5w1muDchyDStQtS9mwsZ35Dgg0LDIvKsUKb8dBz4fVhorm7
	KVEl8BSx9Ke
X-Received: by 2002:a05:6300:67c7:b0:3bf:d354:134f with SMTP id adf61e73a8af0-3c08eebb4a6mr2789538637.44.1783375591418;
        Mon, 06 Jul 2026 15:06:31 -0700 (PDT)
Received: from localhost.localdomain (c-98-232-159-17.hsd1.or.comcast.net. [98.232.159.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d5b95sm84720a12.3.2026.07.06.15.06.28
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 15:06:29 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper][PATCH v4 00/11] Implement 'containers' jobs
Date: Mon,  6 Jul 2026 15:05:32 -0700
Message-ID: <cover.1783371914.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1780710041.git.tim.orling@konsulko.com>
References: <cover.1780710041.git.tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 06 Jul 2026 22:06:34 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4430

This series builds on top of the patches already merged from v2 and
previously submitted as v3.

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

This series relies on the resolution of [3].

The 'vcontainer-tests' job is currently experiencing some failures [4],
which will have to be resolved separately.

[1] https://lore.kernel.org/yocto-patches/02f0c35f16a8a51bbe0e89145353008f67180a84.camel@pbarker.dev/
[2] https://lore.kernel.org/yocto-patches/20260606011918.61582-1-tim.orling@konsulko.com/
[3] https://lore.kernel.org/yocto-meta-virtualization/cover.1783356922.git.tim.orling@konsulko.com/
[4] https://autobuilder.yoctoproject.org/valkyrie/?#/builders/118/builds/4

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

Tim Orling (11):
  scripts: add vcontainer-tarball setup, integration, and publishing
  config.json: add vcontainer-tarball build target
  scripts: add run-vcontainer-tests for meta-virtualization
  scripts: add container registry push, auth, tagging, runtime selection
  config.json: add 'containers-library' build job
  scripts/run-push-containers: push multiarch containers with
    skopeo-native
  containers-library: switch to multiarch; add alpine single-arch
  run-push-containers: conditionally sign pushed containers with cosign
  scripts/run-push-containers: add SPDX SBOM attestation
  config.json: add -dev container builds to containers-library
  run-push-containers: optionally push -dev tagged containers

 config.json                  | 168 +++++++++++++
 scripts/publish-artefacts    |   5 +
 scripts/run-config           |  19 ++
 scripts/run-push-containers  | 471 +++++++++++++++++++++++++++++++++++
 scripts/run-vcontainer-tests | 212 ++++++++++++++++
 scripts/utils.py             |  20 +-
 6 files changed, 891 insertions(+), 4 deletions(-)
 create mode 100755 scripts/run-push-containers
 create mode 100755 scripts/run-vcontainer-tests

These changes can be found:
https://git.yoctoproject.org/yocto-autobuilder-helper/log/?h=contrib/timo/containers-upstream-v4

These changes had a successful build of containers-library job:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/117/builds/25
(with one additional commit to set the path to VCONTAINER_TARBALL_URL)

-- 
2.54.0


