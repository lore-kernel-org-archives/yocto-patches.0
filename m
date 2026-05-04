Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1712CD3423
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 07:28:04 +0000 (UTC)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9726.1777879674426965772
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 04 May 2026 00:27:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=cXSDAlEl;
 spf=pass (domain: gmail.com, ip: 209.85.219.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso14596956d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 00:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777879673; cv=none;
        d=google.com; s=arc-20240605;
        b=T/6JLTjpyuE+e8GAkEQgzvitwgfbP5qOzjENukzTZzf9oRE+/dOEbY0ca9nL3hV0xi
         rpZVdjuYK2QhInebv1l+I9qIS7kYjnDH4mEoZbM8W3P1CkQR1I8fn3WaSbF2ZcNm7OzL
         cWeRvvpTrvUGdjAN32XT3qG26YNQExhPT12V0Xpil7tai/V1vCloCXL0T7w7TDaJS0ct
         5nC68kV/iaZioRnjVtM84a8z6+ohiYTnpNu/As7syJCbhdL9mY/ooGcbAVWcI26look7
         6xzDqnimBkwOjO1Fx2hYZgoRU83ioeBGmdBRfG0PtAWVfipb4iE2Pqmi/P/x6D5TU9qD
         2Jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qvJglj5BeZA88u3v8uY+7Jo+XZZRNq1N7tJgqVYUoyw=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=ERq4rC//IdJwDRj8+EjgiK1eUZMnqPxdjpDU6RyzQeJAo8uqg6iDRWyPfGrcRGkfwg
         JvhVIfOcRA5t9GZPHBzyaYa4QgKAxBvewgYHnKKv/gAtrUIQzaVrqh7PhO4W+iPtyFN5
         3O3FwdVc2/pifAHNG9dRXLlagzZoIDWqZYi/bgT5LVw4ROGKM6xgjRZ5TCuH1FODd3SY
         iYch8U4bZbLyYipVhlJ8R7PgdZyJ3hHMTTz4qKKPjgnw5YLzsmEMqBagBDFeNqbSfp55
         WQbTgTc6zGymdmPNpBUcrMEQyWe2Nmo8Q1Sgfo0keBGCQDiqBkMnl5Cm+0D8pKBHT7A8
         iU2A==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777879673; x=1778484473; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qvJglj5BeZA88u3v8uY+7Jo+XZZRNq1N7tJgqVYUoyw=;
        b=cXSDAlElN/fOzaUZpitQ8q86JnV6jFiVFr6fWGisRW1u5Izbg3GH5DhMGe0ifxGmM3
         B06H+CVtkvWWCrOdlEDvRTXfYOrqt4LczmP4N40Z+TLleDFzXoMUdiZE9t8vq7NbVTRv
         g21FHIZ3RGICE/k9bMdyp0jbEWsfW2SvHyJOYcd4BvrHKdOh1I6D+V3TY0WJXA5KIMe4
         o6Gb+52FTc+00V9G2Y+p+r3mJeOrVr5+JRNbre+hxT2RIymTTSrviFJd6/eBUALaTMzi
         BEo7iF8KXO80P/LCzr+yrOCvQEaeG/lm6CsrFQDrrSKvAIKuUL8/iYffEr/KDLds8J1r
         +Lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777879673; x=1778484473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvJglj5BeZA88u3v8uY+7Jo+XZZRNq1N7tJgqVYUoyw=;
        b=azNZ8YVWkufx8woP4NWpBU8kYTp7g+W6xZdP7iv6CVtQ7N5X4OEl2YblfsAnlKXiY6
         lx3SbS2hVrHQpEYCgjKsnqysemYzgLix+xfJVa28mxVkytyfNM3XtvjNyxFcKxkIrTjz
         4INZRmyGcbu7/sgxznJ968iNeJYZlGUIeBx6R9xHAfTbamXKlaPubCV4DpAj5VUOBI+v
         EhLf8d6IJjJKlNn4bZazpa3bC81hDLgXTJSwRouUi0L//HuXTOQZEDogyR+BOX2+T6LS
         XqLpuylKiWpDA3Se4bAgJJShTTdSnfGdsYpMbDXPUdOwMUedW7U0dF+7Nr5nWI3vxtIt
         EEoA==
X-Gm-Message-State: AOJu0Yy/m6C4Vs3EyuVpLk/NmrEmqc2wwHxBQ7YgC7dLMX76aHJUB3fM
	oOj/jLKZVSKcbT6RfTv7JrNrjw3aDaE8P0zrG5l9n8kIp9lk32kbgKOgIoqQaxycUvRxjTng0V/
	g1/FO/Z0zpNLh5/DkSe8g/pxhoxip6iM=
X-Gm-Gg: AeBDieuqP2okScVk/+E3DBLX7Gr3S9zGL5WPJp0HW+GalgOZvxggrr5Vt08zsOC2cNF
	ddffPubBizrjLyQFmVQRJSMpPOTTytudUWi18ZZgBPmkojMNF2RSf16IJSwHd0FnGo8JO2aV7w2
	4IM9yvUMdkKxllKOl7JXvHLAc3XyBmDhMFVqpJwaYZgnWkmPslNmFE/k7cqvhGovyb4Zfj+PSuz
	l+0w8euu06CxjZuosTTh6mDuE2ccQ+x9wn274Ztv9GRmze9YY7+f6a07EXWUpAWwoQTZVrmiH0L
	9KLuzilB5Yu9nsmNeNeE22LntkPqwqGV8wH8rNm6YvSW8C3aAjHQ
X-Received: by 2002:a05:6214:3d07:b0:8ac:ae66:8eb9 with SMTP id
 6a1803df08f44-8b6693eb878mr151472266d6.46.1777879673330; Mon, 04 May 2026
 00:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260504063614.3831203-1-daniel.turull@ericsson.com> <20260504063614.3831203-4-daniel.turull@ericsson.com>
In-Reply-To: <20260504063614.3831203-4-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 4 May 2026 09:27:42 +0200
X-Gm-Features: AVHnY4JVPoqibWTr83LsOcM-KwMewwvuPx0bkSIl67H3oSAazW55-d8RNpSJ9hA
Message-ID: <CANNYZj9O=uZJ-VvnMP+2TOfqEmzQ18dmDu3VA+19R==XHKPwTg@mail.gmail.com>
Subject: Re: [AUH][PATCH v3 3/4] upgrade-helper.py: Add stable option for
 patch-only upgrades
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 04 May 2026 07:28:04 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3903

This was already discussed, I'm not taking the patch in its current
form. The functionality needs to go to oe-core.

Note also the recent discussion in bitbake-devel list around how to
determine stable versions properly ("add optional major_version
parameter to latest_versionstring").


Alex


On Mon, 4 May 2026 at 08:36, <daniel.turull@ericsson.com> wrote:
>
> From: Daniel Turull <daniel.turull@ericsson.com>
>
> Add --stable flag to restrict upgrades to the next patch version within
> the current stable branch (e.g. 1.2.3 -> 1.2.4). When the latest
> upstream version is a major/minor bump, AUH queries all available
> versions and picks the best patch-level update.
>
> Per-recipe policy can be overridden via AUH_UPGRADE_POLICY (read from
> tinfoil), supporting 'patch' (default), 'minor', and 'none' values.
>
> Quick-path optimization: recipes where next_ver is already a patch
> update are accepted without opening tinfoil. Tinfoil is only opened
> for recipes that need policy lookup or version scanning.
>
> Assisted-by: kiro:claude-opus-4.6
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
> ---
>  modules/utils/version.py | 185 +++++++++++++++++++++++++++++++++++++++
>  upgrade-helper.py        | 104 ++++++++++++++++++++++
>  2 files changed, 289 insertions(+)
>  create mode 100644 modules/utils/version.py
>
> diff --git a/modules/utils/version.py b/modules/utils/version.py
> new file mode 100644
> index 0000000..4417bd5
> --- /dev/null
> +++ b/modules/utils/version.py
> @@ -0,0 +1,185 @@
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
> +#
> +# Requires: beautifulsoup4 (python3-beautifulsoup4 in oe-core)
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
> +    """Check if candidate is a patch-level update.
> +
> +    A patch update changes only the last version component while keeping
> +    all preceding components identical. Also accepts sub-patch extensions
> +    (e.g. 1.2.3 -> 1.2.3.1).
> +    """
> +    cur = _split_version(current_ver)
> +    cand = _split_version(candidate_ver)
> +    if len(cur) < 2 or len(cand) < 2:
> +        return False
> +    if bb.utils.vercmp_string(candidate_ver, current_ver) <= 0:
> +        return False
> +    # All but the last component of the current version must match
> +    # the corresponding prefix of the candidate
> +    if len(cand) < len(cur):
> +        return False
> +    return cur[:-1] == cand[:len(cur) - 1]
> +
> +
> +def is_minor_update(current_ver, candidate_ver):
> +    """Check if candidate is a newer release within the same major version."""
> +    cur = _split_version(current_ver)
> +    cand = _split_version(candidate_ver)
> +    if len(cur) < 2 or len(cand) < 2:
> +        return False
> +    if cur[0] != cand[0]:
> +        return False
> +    return bb.utils.vercmp_string(candidate_ver, current_ver) > 0
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
> +def find_minor_version(current_ver, all_versions):
> +    return _find_best_version(current_ver, all_versions, is_minor_update)
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
> +    fetch = bb.fetch2.Fetch([src_uri], rd)
> +    ud = fetch.ud[fetch.urls[0]]
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
> +            regex_uri = bb.fetch2.encodeurl([ud.type, ud.host, path,
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
> +        W(" Failed to get HTTP versions: %s" % e)
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
> +        W(" Failed to list remote tags: %s" % e)
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
> +            continue
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
> index 9954a66..aecb207 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -59,6 +59,9 @@ from utils.emailhandler import Email
>  from statistics import Statistics
>  from steps import upgrade_steps
>  from testimage import TestImage
> +from utils.version import (is_patch_update, find_patch_version,
> +                           is_minor_update, find_minor_version,
> +                           get_all_upstream_versions)
>
>  if not os.getenv('BUILDDIR', False):
>      E(" You must source oe-init-build-env before running this script!\n")
> @@ -74,6 +77,7 @@ scriptpath.add_bitbake_lib_path()
>  scriptpath.add_oe_lib_path()
>
>  import oe.recipeutils
> +import bb.tinfoil
>
>  help_text = """Usage examples:
>  * To upgrade xmodmap recipe to the latest available version:
> @@ -96,6 +100,9 @@ def parse_cmdline():
>      parser.add_argument("-t", "--to_version",
>                          help="version to upgrade the recipe to")
>
> +    parser.add_argument("--stable", action="store_true", default=False,
> +                        help="only upgrade to the next patch version within the stable branch (e.g. 1.2.3 -> 1.2.4)")
> +
>      parser.add_argument("-d", "--debug-level", type=int, default=4, choices=range(1, 6),
>                          help="set the debug level: CRITICAL=1, ERROR=2, WARNING=3, INFO=4, DEBUG=5")
>      parser.add_argument("-e", "--send-emails", action="store_true", default=False,
> @@ -679,6 +686,67 @@ class UniverseUpdater(Updater):
>
>      def _get_packagegroups_to_upgrade(self, packages=None):
>
> +        def _resolve_stable_version(pn, cur_ver, next_ver, tinfoil):
> +            """Find the best version within the policy allowed by AUH_UPGRADE_POLICY.
> +
> +            Only called when --stable is active. --stable enables version
> +            filtering globally; AUH_UPGRADE_POLICY overrides the policy
> +            per-recipe within that filtering.
> +
> +            AUH_UPGRADE_POLICY can be set per-recipe in local.conf or in the
> +            recipe itself:
> +              "patch" (default) - only patch-level updates (e.g. 1.2.3 -> 1.2.4)
> +              "minor"           - same-major updates (e.g. 1.2.3 -> 1.3.0)
> +              "none"            - skip this recipe entirely
> +            """
> +            # Quick path: if next_ver is already a patch update, accept it
> +            # without parsing the recipe (covers the common case).
> +            if is_patch_update(cur_ver, next_ver):
> +                return next_ver, None
> +
> +            try:
> +                rd = tinfoil.parse_recipe(pn)
> +            except Exception:
> +                rd = None
> +            if not rd:
> +                I(" %s: could not parse recipe, skipping" % pn)
> +                return None, None
> +
> +            policy = (rd.getVar('AUH_UPGRADE_POLICY') or 'patch').strip().lower()
> +            if policy not in ('patch', 'minor', 'none'):
> +                W(" %s: unrecognized AUH_UPGRADE_POLICY '%s',"
> +                  " defaulting to 'patch'" % (pn, policy))
> +                policy = 'patch'
> +            if policy == 'none':
> +                I(" %s: AUH_UPGRADE_POLICY=none, skipping" % pn)
> +                return None, None
> +
> +            if policy == 'minor':
> +                check_fn = is_minor_update
> +                find_fn = find_minor_version
> +            else:
> +                check_fn = is_patch_update
> +                find_fn = find_patch_version
> +
> +            if check_fn(cur_ver, next_ver):
> +                return next_ver, None
> +
> +            I(" %s: latest version %s is not a %s update from %s,"
> +              " searching for versions..." %
> +              (pn, next_ver, policy, cur_ver))
> +            try:
> +                all_versions = get_all_upstream_versions(rd)
> +                ver = find_fn(cur_ver, all_versions)
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
> @@ -736,6 +804,42 @@ class UniverseUpdater(Updater):
>                          upgrade_group.append(pkg_to_upgrade)
>                  if upgrade_group:
>                      upgrade_pkggroups.append(upgrade_group)
> +
> +        if self.args.stable and upgrade_pkggroups:
> +            # Quick-path: accept packages where next_ver is already a patch
> +            # update without opening tinfoil.  For the rest, tinfoil must
> +            # remain open because bb.fetch2.Fetch needs a live rd object.
> +            needs_tinfoil = []
> +            for group in upgrade_pkggroups:
> +                quick_group = []
> +                slow_pkgs = []
> +                for pkg in group:
> +                    if is_patch_update(pkg['cur_ver'], pkg['next_ver']):
> +                        quick_group.append(pkg)
> +                    else:
> +                        slow_pkgs.append(pkg)
> +                if quick_group or slow_pkgs:
> +                    needs_tinfoil.append((quick_group, slow_pkgs))
> +
> +            if any(slow for _, slow in needs_tinfoil):
> +                stable_tinfoil = bb.tinfoil.Tinfoil()
> +                stable_tinfoil.prepare(config_only=False)
> +                try:
> +                    for quick_group, slow_pkgs in needs_tinfoil:
> +                        for pkg in slow_pkgs:
> +                            ver, rev = _resolve_stable_version(
> +                                pkg['pn'], pkg['cur_ver'],
> +                                pkg['next_ver'], stable_tinfoil)
> +                            if ver is not None:
> +                                pkg['next_ver'] = ver
> +                                if rev is not None:
> +                                    pkg['revision'] = rev
> +                                quick_group.append(pkg)
> +                finally:
> +                    stable_tinfoil.shutdown()
> +
> +            upgrade_pkggroups = [g for g, _ in needs_tinfoil if g]
> +
>          return upgrade_pkggroups
>
>      def pkg_upgrade_handler(self, pkg_ctx):
> --
> 2.34.1
>

