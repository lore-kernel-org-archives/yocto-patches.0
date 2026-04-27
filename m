Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD654FF8861
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 10:15:30 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40254.1777284922838451990
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 03:15:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gQwwWblZ;
 spf=pass (domain: gmail.com, ip: 209.85.160.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e614fdb42so78002461cf.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 03:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777284922; cv=none;
        d=google.com; s=arc-20240605;
        b=CSx71rIY7g+Tyt7q0Ebvdf1R4E/0Eipf+muKs5KFaOdkI9Q6m6T/rhTaY4KZoS4j7v
         0Uprg1TRNByzulcEoYg8s3vNOKtGrD5Py09k2m7eA3tdyjioQAFEzUvSan4iN4CNU/iU
         5BAoSPRA9Zoe6zNJtKSSgQh9A5CzuqCfsKTjydS2GJ09gsTDUpQB65y5yyrgqypXC8lB
         4LB9bMWo1TX4GNqSxrG+Jt92/xNsX+le1V/wRS9nlKCb8GVD2YJrT9iZX0mKuLunjiRf
         /jey+Ob9g2LLTrPDXCB0ndnEm3NrWeOxUv95yWQoi5Gumbc4tG3OXB2R0ZUOXEHqacjj
         LEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8hHfd8E5OLET7TqmwSJiX1dtnoOrIdoZTogByWvBopU=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=G8eEiVeNEjfgYOFTLz2QoR7SNJxYV8h8VM8keaxb7PdO2Epx7XCMxUxhFX+aaHnSeu
         Oh3LiE0fIO+x5cvGrPODuw6TU+dAn3i5EryPSCQx9J7W0iBiL3Sg+bLOM/w2GfSzkYRT
         t6+I71AH0+h0JIxuYdlgZttNC2eCbx+YhifMo2wsyBItHdhfffsgtb8U4bAkCO+nNznH
         /RzWNombZamWjazkNBPTj2HtNLlkx/qlKthERL4pYcGKY1vbmm6SWbswoJAursUfhy0N
         4/Qwg7jKoHdGHpwYVzXtmvg+S8LJv00uvMxomB1qxF2ek/fR4fjU6VneM4eNamAIQ2/Z
         udEw==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284922; x=1777889722; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8hHfd8E5OLET7TqmwSJiX1dtnoOrIdoZTogByWvBopU=;
        b=gQwwWblZq0peq+BVgDxS4kc4CcdTwupXeu64DVqZfR5vIfojYmUnrmiFqDlZBdOA17
         L02LGBZ4mZFX/SK2coDONrbPvxuz0mWGJaLcvmfA9tx4JHTzkiHoCiKemOVs8mYD9uUb
         Vxdr9rV5XWEH7HNIgtImwMltYShisMpexs0DrjJLB1Pw+QwfwsD97eN4O1PVI36+fYFx
         HBXrB5qgo/iYZb2Pe5EhXArchifrJWK4Xndizfvk11nor5G3XlohhEwLruB+udiVYmL4
         X/7WND4xVO9WGdhy4O/opM96XAJCsk3Ssx2DbF0qSeXygMgyRLApp/zG11CxHKG6i0Gf
         p58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284922; x=1777889722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hHfd8E5OLET7TqmwSJiX1dtnoOrIdoZTogByWvBopU=;
        b=VQpgZtiZfSWk0M7bPVMz/t9CIomxG9SSYzopr1DiF5yBW7e3pNzE1B2mPuZJKs0Z8y
         Prj0QMQv9d/P1BX80KN3QUw9EActqNMPK3V0zvLYPcvXWetR1OSzG5fasPLKops2EAge
         Njd4nnTzp9EmeCo4keSgaNut5K7xI6d9W1UHnOcaoY8lB5HXotzQuQGYK3bi7mAbAJ84
         qDDr3LGlYHdoWYObe9evBNxqN7f4RYzIQUhbnaW5d4VjMXrlH+ENRGbhxSIC0zOvBJut
         XesGbNt2AdhEuNqV98HBERqany5TPJ5gs03FSvz5DnHncgZDJDnYBMoAp8OX4v4lc61H
         xPdQ==
X-Gm-Message-State: AOJu0YzQecmZlR2JRjUVC2tHX1uuOG5cmq2i9GvV34b28N7wu52K2XIr
	BlsPsQsTvBvIlRLMCQ73G3Z0kjCg6ebeCZOYxVkGpMz064hSMu0eiH7dd6+/aiO9Fqx6VAjb4z8
	m9kVQjUeRbt7OfhaE+x+CmriReHuH3F0=
X-Gm-Gg: AeBDieuW52oVBAL4ewigeR2FxuzRmPjTCaJRHsq5O1wRcgXRg5MiRDYmvNBbKYu92za
	Ah8l78LwpWGI/o/jnUX2Sx1N+XEAn+jMr68rB4OEMOb4hl3anhkOhfeKGcB8/62QseQcZM7OTdZ
	mvpWDpc6pC79i8klFsq/JlLHrExKt/rWKdfo6D3Aq7S3/Nvx69T4SSzUxiXsvNgnWuHC0SB//lH
	o3icUa4f8QMXVJ1KA5OCPD6qyHf+pHDXxeVxHwDUGe/PO9ObTnL3Q0qCYxAkblAqResmL8zrTui
	VTlQaxDNOx96iZ2sZPvriEdxze2QMFsVv2OhnFpKjEgbzs5t5JdVcHNvQ0uVTS8=
X-Received: by 2002:a05:622a:4c87:b0:50f:bdeb:1e47 with SMTP id
 d75a77b69052e-50fbdeb24e1mr403745011cf.44.1777284921709; Mon, 27 Apr 2026
 03:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com> <20260424114603.2444938-6-daniel.turull@ericsson.com>
In-Reply-To: <20260424114603.2444938-6-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 12:15:10 +0200
X-Gm-Features: AVHnY4JXUQaoIbkbToKJiiwBrvhiSWEW1_l_tNzQ4W8Y9sjhpuNGSetjCLqSwuw
Message-ID: <CANNYZj-fo-N=O2FLAi4KM2neUoy6f9u6ucKAozMzGpvfEtHy2w@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 5/9] upgrade-helper.py: Add stable option for
 patch-only upgrades
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 10:15:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3834

This functionality really needs to go to oe-core, and it should be
based on recipe metadata, e.g. for things like openssl we could
indicate in the recipe that stable maintenance is done with point
version releases, or systemd is maintained via minor versions (259.3
-> 259.4) or glibc has commits on a maintenance branch. You can't
assume that point releases are equivalent to bugfix-only maintenance.

So that you could run e.g. 'devtool check-upgrade-status --stable' and
it would print a list of possible maintenance updates.

Alex

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:
>
> From: Daniel Turull <daniel.turull@ericsson.com>
>
> Add --stable flag to restrict upgrades to the next patch version within
> the current stable branch (e.g. 1.2.3 -> 1.2.4). When the latest
> upstream version is a major/minor bump, AUH queries all available
> versions and picks the best patch-level update.
>
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
> Assisted-by: Claude, Anthropic
> ---
>  modules/utils/version.py | 160 +++++++++++++++++++++++++++++++++++++++
>  upgrade-helper.py        |  51 +++++++++++++
>  2 files changed, 211 insertions(+)
>  create mode 100644 modules/utils/version.py
>
> diff --git a/modules/utils/version.py b/modules/utils/version.py
> new file mode 100644
> index 0000000..b40eb1c
> --- /dev/null
> +++ b/modules/utils/version.py
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Version utilities for --stable patch-only upgrades.
> +#
> +# get_all_upstream_versions() collects *all* available upstream versions so
> +# that we can pick the highest patch-level release within the current stable
> +# branch.  The existing bitbake/oe-core APIs (latest_versionstring,
> +# get_recipe_upstream_version) only return the single highest version, so we
> +# must re-implement the inner loops here.
> +#
> +# The HTTP path mirrors bb.fetch2.wget.Wget._check_latest_version() and the
> +# git path mirrors bb.fetch2.git.Git.latest_versionstring(), both from
> +# bitbake scarthgap.  We cannot modify oe-core on a stable release, hence
> +# the duplication.
> +
> +import functools
> +import re
> +from logging import warning as W
> +
> +import bb.utils
> +import bb.fetch2
> +from bs4 import BeautifulSoup, SoupStrainer
> +
> +
> +def _split_version(ver):
> +    # Split on '.', '-', '_' and letter-digit boundaries (e.g. 10.0p2 -> [10, 0, p, 2])
> +    parts = re.split(r'[\.\-_]', ver)
> +    result = []
> +    for p in parts:
> +        result.extend(re.split(r'(?<=[a-zA-Z])(?=\d)|(?<=\d)(?=[a-zA-Z])', p))
> +    return result
> +
> +
> +def is_patch_update(current_ver, candidate_ver):
> +    cur = _split_version(current_ver)
> +    cand = _split_version(candidate_ver)
> +    if len(cur) != len(cand) or len(cur) < 3:
> +        return False
> +    if cur[:-1] != cand[:-1]:
> +        return False
> +    try:
> +        return int(cand[-1]) > int(cur[-1])
> +    except ValueError:
> +        return bb.utils.vercmp_string(candidate_ver, current_ver) > 0
> +
> +
> +def _find_best_version(current_ver, all_versions, filter_fn):
> +    candidates = [v for v in all_versions if filter_fn(current_ver, v)]
> +    if not candidates:
> +        return None
> +    candidates.sort(
> +        key=functools.cmp_to_key(bb.utils.vercmp_string), reverse=True
> +    )
> +    return candidates[0]
> +
> +
> +def find_patch_version(current_ver, all_versions):
> +    return _find_best_version(current_ver, all_versions, is_patch_update)
> +
> +
> +def get_all_upstream_versions(rd):
> +    """Get all upstream versions using the fetcher infrastructure.
> +
> +    Unlike ud.method.latest_versionstring() which returns only the highest
> +    version, this collects every version so the caller can filter for
> +    patch-only updates.
> +    """
> +    src_uris = rd.getVar('SRC_URI')
> +    if not src_uris:
> +        return []
> +
> +    src_uri = src_uris.split()[0]
> +    ud = bb.fetch2.FetchData(src_uri, rd)
> +
> +    if ud.type == 'git':
> +        return _get_git_versions(ud, rd)
> +    return _get_http_versions(ud, rd)
> +
> +
> +def _get_http_versions(ud, rd):
> +    """Collect all upstream versions from an HTTP index page.
> +
> +    Adapted from bb.fetch2.wget.Wget._check_latest_version() and
> +    ._init_regexes().  The upstream code only keeps the highest version;
> +    we collect them all.  Uses BeautifulSoup to parse <a> tags, matching
> +    the upstream behaviour.
> +    """
> +    try:
> +        package = ud.path.split("/")[-1]
> +
> +        regex_uri = rd.getVar('UPSTREAM_CHECK_URI')
> +        if not regex_uri:
> +            path = ud.path.split(package)[0]
> +            regex_uri = bb.fetch.encodeurl([ud.type, ud.host, path,
> +                                            ud.user, ud.pswd, {}])
> +
> +        page = ud.method._fetch_index(regex_uri, ud, rd)
> +        if not page:
> +            return []
> +
> +        regex = rd.getVar('UPSTREAM_CHECK_REGEX')
> +        if regex:
> +            regex = re.compile(regex)
> +        else:
> +            regex = ud.method._init_regexes(package, ud, rd)
> +        if not regex:
> +            return []
> +
> +        # Parse HTML links, same as Wget._check_latest_version()
> +        soup = BeautifulSoup(page, "html.parser",
> +                             parse_only=SoupStrainer("a"))
> +        if not soup:
> +            return []
> +
> +        versions = set()
> +        for link in soup.find_all('a', href=True):
> +            for text in (link['href'], str(link)):
> +                m = regex.search(text)
> +                if m and 'pver' in m.groupdict() and m.group('pver'):
> +                    versions.add(re.sub('_', '.', m.group('pver')))
> +                    break
> +        return list(versions)
> +    except Exception as e:
> +        W(" Failed to get HTTP versions: %s" % str(e))
> +        return []
> +
> +
> +def _get_git_versions(ud, rd):
> +    """Collect all tagged versions from a git remote.
> +
> +    Adapted from bb.fetch2.git.Git.latest_versionstring().  The upstream
> +    code only keeps the highest version; we collect them all.
> +    """
> +    try:
> +        output = ud.method._lsremote(ud, rd, "refs/tags/*")
> +    except (bb.fetch2.FetchError, bb.fetch2.NetworkAccess, OSError) as e:
> +        W(" Failed to list remote tags: %s" % str(e))
> +        return []
> +
> +    rev_tag_re = re.compile(r"([0-9a-f]{40})\s+refs/tags/(.*)")
> +    pver_re = re.compile(
> +        rd.getVar('UPSTREAM_CHECK_GITTAGREGEX')
> +        or r"(?P<pver>([0-9][\.|_]?)+)"
> +    )
> +    nonrel_re = re.compile(r"(alpha|beta|rc|final)+")
> +
> +    versions = set()
> +    for line in output.split("\n"):
> +        if not line:
> +            break
> +        m = rev_tag_re.match(line)
> +        if not m:
> +            continue
> +        tag = m.group(2)
> +        if nonrel_re.search(tag):
> +            continue
> +        m = pver_re.search(tag)
> +        if m:
> +            versions.add(m.group('pver').replace("_", "."))
> +    return list(versions)
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 327bb6d..b7b8ddf 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -59,6 +59,7 @@ from utils.emailhandler import Email
>  from statistics import Statistics
>  from steps import upgrade_steps
>  from testimage import TestImage
> +from utils.version import is_patch_update, find_patch_version, get_all_upstream_versions
>
>  if not os.getenv('BUILDDIR', False):
>      E(" You must source oe-init-build-env before running this script!\n")
> @@ -74,6 +75,7 @@ scriptpath.add_bitbake_lib_path()
>  scriptpath.add_oe_lib_path()
>
>  import oe.recipeutils
> +import bb.tinfoil
>
>  help_text = """Usage examples:
>  * To upgrade xmodmap recipe to the latest available version:
> @@ -97,6 +99,8 @@ def parse_cmdline():
>                          help="version to upgrade the recipe to")
>      parser.add_argument("--changelog", action="store_true", default=False,
>                          help="extract changelog between old and new versions, highlighting CVEs")
> +    parser.add_argument("--stable", action="store_true", default=False,
> +                        help="only upgrade to the next patch version within the stable branch (e.g. 1.2.3 -> 1.2.4)")
>
>      parser.add_argument("-d", "--debug-level", type=int, default=4, choices=range(1, 6),
>                          help="set the debug level: CRITICAL=1, ERROR=2, WARNING=3, INFO=4, DEBUG=5")
> @@ -698,6 +702,30 @@ class UniverseUpdater(Updater):
>
>      def _get_packagegroups_to_upgrade(self, packages=None):
>
> +        def _resolve_stable_version(pn, cur_ver, next_ver, tinfoil):
> +            """Find the latest patch version within the current stable branch."""
> +            if is_patch_update(cur_ver, next_ver):
> +                return next_ver, None
> +            I(" %s: latest version %s is not a patch update from %s,"
> +              " searching for versions..." %
> +              (pn, next_ver, cur_ver))
> +            try:
> +                rd = tinfoil.parse_recipe(pn)
> +                if not rd:
> +                    I(" %s: could not parse recipe, skipping" % pn)
> +                    return None, None
> +                all_versions = get_all_upstream_versions(rd)
> +                ver = find_patch_version(cur_ver, all_versions)
> +                if ver:
> +                    I(" %s: found version %s" % (pn, ver))
> +                    return ver, "N/A"
> +                else:
> +                    I(" %s: no suitable version available, skipping" % pn)
> +                    return None, None
> +            except Exception as e:
> +                I(" %s: failed to search for versions: %s" % (pn, e))
> +                return None, None
> +
>          # Prepare a single pkg dict data (or None is not upgradable) from recipeutils.get_recipe_upgrade_status data.
>          def _get_pkg_to_upgrade(self, layer_name, pn, status, cur_ver, next_ver, maintainer, revision, no_upgrade_reason):
>              pkg_to_upgrade = None
> @@ -763,6 +791,29 @@ class UniverseUpdater(Updater):
>                          upgrade_group.append(pkg_to_upgrade)
>                  if upgrade_group:
>                      upgrade_pkggroups.append(upgrade_group)
> +
> +        if self.args.stable and upgrade_pkggroups:
> +            stable_tinfoil = bb.tinfoil.Tinfoil()
> +            stable_tinfoil.prepare(config_only=False)
> +            try:
> +                filtered = []
> +                for group in upgrade_pkggroups:
> +                    filtered_group = []
> +                    for pkg in group:
> +                        stable_ver, stable_rev = _resolve_stable_version(
> +                            pkg['pn'], pkg['cur_ver'], pkg['next_ver'],
> +                            stable_tinfoil)
> +                        if stable_ver is not None:
> +                            pkg['next_ver'] = stable_ver
> +                            if stable_rev is not None:
> +                                pkg['revision'] = stable_rev
> +                            filtered_group.append(pkg)
> +                    if filtered_group:
> +                        filtered.append(filtered_group)
> +                upgrade_pkggroups = filtered
> +            finally:
> +                stable_tinfoil.shutdown()
> +
>          return upgrade_pkggroups
>
>      def pkg_upgrade_handler(self, pkg_ctx):
> --
> 2.34.1
>

