Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0993A10FCAE2
	for <webhook@archiver.kernel.org>; Wed,  1 Apr 2026 20:59:37 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1983.1775077170474109324
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 01 Apr 2026 13:59:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=t5tWPCEF;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cfd44fa075so32479685a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1775077169; x=1775681969; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/nilYLaHlVSoZHOw+UwwUac6wakUYnsT0CdTUNI4XE=;
        b=t5tWPCEF8hQnRzdnzlIigpBP7HCvegNDstCfy8lAwuf0bK7Cyzr/H3bLQb2ra8Tkiq
         oISukDYWDKyugnLn/mH4BRObnI0jyucS2UNkSPMnGz789qKZDjyQohVuykcuVPH9HGPr
         LEIErni9B4hBNap8HFuUM2MuC4aEmELCqE6S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077169; x=1775681969;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h/nilYLaHlVSoZHOw+UwwUac6wakUYnsT0CdTUNI4XE=;
        b=Gy2XNXdSxmecYPJJj9BIWvu8fFJrcKWLE8ger3FuomsVQk4MvtVeRxSOGjHCftp14J
         DrhmhM1meHFiw+lOE7wfxJGClS53ogadsMin7ibni7WwQRBTJc51hgbWWGIbSnjmhprG
         dknNTvOMBld0qMsxp0qobS62HXepUrQq2bkvdhSi6GiUUWvGztRtPWw5oGSzGHBJwfHZ
         OfwfNt/yjzUfOacQXZaT7034W8+wdf+HqM3J+Lk0AYH4iTwSvlbZfin+5kj/u3FZeE8y
         5b/xogAvBK2f+Oc3nbHCafc3IdZbJpD8uJt8Xpvl7MUE01zaSjMZhJanFfWuriFklvWf
         GI3g==
X-Gm-Message-State: AOJu0YwsaSyg5I1vr/s8mPILvqDTd5j3puCrkZ2ZSTUs2+QVVI/ifQIF
	u8VgErSItLoOszuSgpBjC4+mbfkIR98fNK0t18hfiAeC0GxFAxRQzLqf132chgtaKFhvXM3UsAn
	lPbKp
X-Gm-Gg: ATEYQzy2+phzVokNc1Y9YX1/PEfrZmLA1No0YzNgxsaekI8m/Jkr/edaBbBmIrA5uTP
	kvS2Kb1OM9TqBR7SsnNKVt5woFVBlENxULdYUqbUo/YysvSd2trXu8tQPiQ+IsWDe5GeoC6IwGS
	t+NKIxI1n6zb/7xIJqOP2JXwe7e1cmaXq7W0whuoxUkRcBTFl6+0JUZeKZ3bXH42TCzoyMO3bSA
	7G6IPlJniDrYUa928YpiFcnsVdaI75fzDDU6zPoabxa08BMNDBA8mtGBjgCuIujd18SkY5bMXxm
	jIJ4sxxQlGeK3L9YJsles+NkKNv9XQXr8pAnSay8CCEzE59UwIEGoDAVBKa6VORzAIEgPSR8yJr
	Od2JTVyQiPCqM4beR84oymuzb2Ax5POlzULp3sE9G0r0TdMtzjTRtpb7CUSz/Rk7D4kLFfBVssB
	+IZv5KoyR05wJiwNsbGXdUK0X8Bgql0tYAVBSEuvDLMXHVaBOXsWJoAKcwgxeXv6D8YptK4S0rn
	wctBpZ/RYXUP0w8+ijzTEdEC2Mj2+/u/9l8G6O9yvei7ak=
X-Received: by 2002:a05:620a:408c:b0:8cf:d62a:c814 with SMTP id af79cd13be357-8d1b5af5e99mr771454885a.19.1775077164455;
        Wed, 01 Apr 2026 13:59:24 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596e03cd8sm5938806d6.33.2026.04.01.13.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:59:24 -0700 (PDT)
Date: Wed, 1 Apr 2026 16:59:09 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
cc: mingli.yu@eng.windriver.com
Subject: Re: [yocto-patches] [meta-security][PATCH] scap-security-guide:
 Replace pkg_resources.Requirement
In-Reply-To: <20260331023812.3353409-1-mingli.yu@windriver.com>
Message-ID: <fd46b294-d313-1a0a-2c61-0abc08b5bcbe@konsulko.com>
References: <20260331023812.3353409-1-mingli.yu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 01 Apr 2026 20:59:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3598

On Tue, 31 Mar 2026, Yu, Mingli via lists.yoctoproject.org wrote:

> From: Mingli Yu <mingli.yu@windriver.com>
>
> Backport a patch [1] to fix below build error.
>  | ModuleNotFoundError: No module named 'pkg_resources'
>
> [1] https://github.com/ComplianceAsCode/content/commit/12f2503

It would make more sense to upgrade to v0.1.80 which includes this fix.
If you don't get to it in the next couple of days, I'll try to get it
done in the next week (I've some personal travel, so no guarantees).

Scott


> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>  ...01-Replace-pkg_resources.Requirement.patch | 127 ++++++++++++++++++
>  .../scap-security-guide_0.1.78.bb             |   1 +
>  2 files changed, 128 insertions(+)
>  create mode 100644 recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch
>
> diff --git a/recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch b/recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch
> new file mode 100644
> index 0000000..604e099
> --- /dev/null
> +++ b/recipes-compliance/scap-security-guide/files/0001-Replace-pkg_resources.Requirement.patch
> @@ -0,0 +1,127 @@
> +From 12f2503c51484005f29dad75c80395352ac8b668 Mon Sep 17 00:00:00 2001
> +From: Matthew Burket <mburket@redhat.com>
> +Date: Tue, 18 Nov 2025 18:32:45 -0600
> +Subject: [PATCH] Replace pkg_resources.Requirement
> +
> +Replaced pkg_resources with a custom RequirementParser.
> +It implements just enough of pkg_resources.Requirement to work for our
> +project.
> +
> +Fixes: #13902
> +
> +Upstream-Status: Backport [https://github.com/ComplianceAsCode/content/commit/12f2503]
> +
> +Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> +---
> + ssg/requirement_specs.py                      | 51 ++++++++++++++-----
> + .../unit/ssg-module/test_requirement_specs.py | 11 ++++
> + 2 files changed, 49 insertions(+), 13 deletions(-)
> +
> +diff --git a/ssg/requirement_specs.py b/ssg/requirement_specs.py
> +index 10e6a6f35d..16637ddff8 100644
> +--- a/ssg/requirement_specs.py
> ++++ b/ssg/requirement_specs.py
> +@@ -1,18 +1,43 @@
> + """
> + Common functions for processing Requirements Specs in SSG
> + """
> +-
> +-import pkg_resources
> + import re
> ++from typing import Tuple, List
> +
> + from ssg import utils
> +
> +-# Monkey-patch pkg_resources.safe_name function to keep underscores intact
> +-# Setuptools recognize the issue: https://github.com/pypa/setuptools/issues/2522
> +-pkg_resources.safe_name = lambda name: re.sub('[^A-Za-z0-9_.]+', '-', name)
> +-# Monkey-patch pkg_resources.safe_extras function to keep dashes intact
> +-# Setuptools recognize the issue: https://github.com/pypa/setuptools/pull/732
> +-pkg_resources.safe_extra = lambda extra: re.sub('[^A-Za-z0-9.-]+', '_', extra).lower()
> ++
> ++class RequirementParser:
> ++    name: str
> ++    operation: str
> ++    version: str
> ++    extra: str
> ++
> ++    def __init__(self, target_v):
> ++        match = re.match(r'^(?P<name>[a-zA-Z0-9\-_.]+)\[?(?P<extra>[a-zA-Z0-9\-_]+)?]?\s*(?P<operation>[><!~=]*)?\s*(?P<version>.*)?$',
> ++                         target_v)
> ++        if match:
> ++            self.name = match.groupdict().get('name', '')
> ++            self.operation = match.groupdict().get('operation', '')
> ++            self.version = match.groupdict().get('version', '')
> ++            self.extra = match.groupdict().get('extra', '')
> ++
> ++    @property
> ++    def specs(self) -> List[Tuple[str, str]]:
> ++        if self.operation and self.version:
> ++            return [(self.operation, self.version)]
> ++        else:
> ++            return []
> ++
> ++    @property
> ++    def project_name(self) -> str:
> ++        return self.name
> ++
> ++    @property
> ++    def extras(self) -> List[str]:
> ++        if self.extra:
> ++            return [self.extra.lower()]
> ++        return []
> +
> +
> + def _parse_version_into_evr(version):
> +@@ -62,11 +87,11 @@ class Requirement:
> +     A class to represent a package requirement with version specifications.
> +
> +     Attributes:
> +-        _req (pkg_resources.Requirement): The parsed requirement object.
> ++        _req (RequirementParser): The parsed requirement object.
> +         _specs (utils.VersionSpecifierSet): The set of version specifiers for the requirement.
> +     """
> +-    def __init__(self, obj):
> +-        self._req = pkg_resources.Requirement.parse(obj)
> ++    def __init__(self, obj: str):
> ++        self._req = RequirementParser(obj)
> +         self._specs = utils.VersionSpecifierSet(
> +             [_spec_to_version_specifier(spec) for spec in self._req.specs]
> +         )
> +@@ -131,7 +156,7 @@ class Requirement:
> +             bool: True if the package requirement is parametrized (includes extras),
> +                   False otherwise.
> +         """
> +-        return bool(pkg_resources.Requirement.parse(name).extras)
> ++        return bool(RequirementParser(name).extras)
> +
> +     @staticmethod
> +     def get_base_for_parametrized(name):
> +@@ -144,4 +169,4 @@ class Requirement:
> +         Returns:
> +             str: The base project name of the package.
> +         """
> +-        return pkg_resources.Requirement.parse(name).project_name
> ++        return RequirementParser(name).project_name
> +diff --git a/tests/unit/ssg-module/test_requirement_specs.py b/tests/unit/ssg-module/test_requirement_specs.py
> +index 13c3292b5f..ae078e9a8f 100644
> +--- a/tests/unit/ssg-module/test_requirement_specs.py
> ++++ b/tests/unit/ssg-module/test_requirement_specs.py
> +@@ -33,3 +33,14 @@ def test_parse_version_into_evr():
> +         v = requirement_specs._parse_version_into_evr(':')
> +     with pytest.raises(ValueError):
> +         v = requirement_specs._parse_version_into_evr('-')
> ++
> ++def test_requirement_parse():
> ++    req = requirement_specs.RequirementParser("package[NetworkManager]>=8.7")
> ++    assert req.project_name == 'package'
> ++    assert req.operation == '>='
> ++    assert req.version == '8.7'
> ++    assert req.extras == ['networkmanager']
> ++    assert req.specs == [('>=', '8.7')]
> ++
> ++    req = requirement_specs.RequirementParser('linux_os')
> ++    assert req.project_name == 'linux_os'
> +--
> +2.34.1
> +
> diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
> index 919a09c..e42b054 100644
> --- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
> +++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.78.bb
> @@ -8,6 +8,7 @@ LICENSE = "BSD-3-Clause"
>
>  SRCREV = "f7d794851971087db77d4be8eeb716944a1aae21"
>  SRC_URI = "git://github.com/ComplianceAsCode/content.git;protocol=https;branch=stable \
> +           file://0001-Replace-pkg_resources.Requirement.patch \
>             file://run_eval.sh \
>             "
>
>

