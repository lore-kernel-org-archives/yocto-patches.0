Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7914FF8861
	for <webhook@archiver.kernel.org>; Mon, 27 Apr 2026 10:01:39 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40059.1777284097875954486
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 27 Apr 2026 03:01:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DtyTrM0W;
 spf=pass (domain: gmail.com, ip: 209.85.222.179, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d7e7f48499so1135631385a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 03:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777284097; cv=none;
        d=google.com; s=arc-20240605;
        b=j8VeToeQocQDrWDDhH4NMjz73LNYmYMAgmZWzGCGzw8pfJmzrQ+z8bnCRxJ/ebDgLW
         DidQuxKqc2QqHHeNFqboW560dohBNGx7y/O5rVDGneIZbuJpRoNnMXdp/CAc/Zlh7hES
         ik7T0FCKF7dt+ZMCPk0w9nP1PmEBg1jaMPbnAMRZQAObqK+k26FiptTrNvJgQdN0QKns
         oP0cK/uCZPFLs0mR2O/q6+UJXD45+CwD40+W8h5e57n+80B4ywcj/wBNHI4h6fUrf2EA
         epVa3mcjXE6IjG/1u+0zKtI6DRy8N+gnG5H/VimDvRUKvEHl9Z/wSQ6WwN+mCnZGynbz
         jDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dg/n5+6kbBQxRorPeum98h3SXFNSQAOd+nDPVbXYaAU=;
        fh=B6+dp47eghNzyj8BrWGHk2n/ObAtmJy/gW8Hzrmb+f8=;
        b=XLhV08oeS7yptZJXkbYI4vmw13jLoinkVLseroxN16dvF1RvDZZ7WqvTKfeI8iefQD
         7wg1gvySOWcWlk2/JfoMMUEI5JIzp3CUN5G91TlPQip/6OeX0fU6cZfGbIN49hnlYiea
         O1FrtWRdYxqqEFDaFgFvpafNBaVJrCcSeq3e8BwEFF287DbNZRvMWXB0V3yUB/agVO97
         tSYc2aMAM0xGTqybb0qCHa9W/EzXRj6syuD8pVGiJ5WXJHpxhSccI3YXjJ0nv622WOPw
         +lgx6/Nd6AiLWFmzHFpTbmCep+aMe7tB8yZ3rm5OLRdVHSNmmFW4rNHgo6RjsxjtAJ9z
         P/Og==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284097; x=1777888897; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dg/n5+6kbBQxRorPeum98h3SXFNSQAOd+nDPVbXYaAU=;
        b=DtyTrM0WlRy9V5A0ASlAMsRFhMZykGRZQSf5OegjZcRtB6bBmbhNlY5WgjbF7asaue
         GeQ3De8ABBa5xy8/mYzwr2Clc36do3EJNXcLAdGtlKZxVkZ5S7yHJI720kMikGNMDDoj
         tYHSvLXTDJ+W4REvSmIo6NIZIhk6T39JNtgoyP10JJF05Hu6LatsR+dnWarlsWnws+NE
         DOQDrvU0H5NyVRPgeV1iYa3zSlbxGh6koLuPJIFkNeACNmlGv1n8JxEX96DceVTbGsDm
         4lGkDEEIOhqA3k1nsOsKpX6YNyzadexA3yWIU7hsm2gczdFgZJGUdUo2TZJk1FjVfcCp
         Md8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284097; x=1777888897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dg/n5+6kbBQxRorPeum98h3SXFNSQAOd+nDPVbXYaAU=;
        b=OAbM1591Lg2p/tn+NcltpnU/eJFTGdeVYnRclLXbJyuoxkGzEK6iUylJbZXq9mR2Nc
         QH3pdp+mEkk4eJftsHA2KbrfaQ4yUNYUr4ysf1my9Di/KNoYKWqNh3R9Ipn5HAOInoan
         fI1XSWZyfD6tLueh8D2Ettf855yje86+Yp+d6m0SihdjR0hPvRwxry9UPc5aCZB8PSS7
         OPakP4G+Z56NRqJ4utjvGNFvYvDBRciBA81OfkqZL5y3lpNVO/CgRB0XQCINIOEIL7HS
         3sIYz0NYb3yOF7QItvUMH59ssdf6Q8eNYhR+YTBlWl3KR5Y9YSS/w7YKtdxpZG+wpCX3
         1rkw==
X-Gm-Message-State: AOJu0Yygu2hW49ShJHlefgxaettnemxjymVFsiEDOhLIm6tExhE82uNM
	W/oABr7sl40F4oO7bORxA3uYa8xF7j09Ax63wdf+MxwSXct6VQW+pZnZuJJT8qRxC7aNuPt5Dtu
	rViOKCYY2Gl/y7QewGgQ3zhGqv1VjPls=
X-Gm-Gg: AeBDiet6drGoZxlrxTB1POOFCtGOny1gqes2Vmsn96a+6wFvykA4sbuZX9kxJvR3BGt
	4mgwePVga/fr2eoIJOHtHeST2YC0AovEWTy8RrplvOLh7ojMRgKu95am1NYM08OEcfvyPPW7O0h
	sjaBnqzhRYD1EwK1yY5bj0eAfhp8l/P1jExm9yc6K53gFfe1lU2lXxPFDP4DqYMkCtxeYc9AB0t
	w7GLJactjQWuibeDDwy+lzI6oXSpo1zeOzCZQKxQLGlo8IDAEUqhxbXpn5DB6tXEP/K5YlMBu+h
	/3GOJ/MZLD9lb81qXkRUTCdTyW80jygIOuDiYTESINC6Hs1ARfX5
X-Received: by 2002:a05:6214:3a82:b0:8ac:a9d2:9404 with SMTP id
 6a1803df08f44-8b0280cc33fmr648885266d6.30.1777284096618; Mon, 27 Apr 2026
 03:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260424114603.2444938-1-daniel.turull@ericsson.com> <20260424114603.2444938-5-daniel.turull@ericsson.com>
In-Reply-To: <20260424114603.2444938-5-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Mon, 27 Apr 2026 12:01:23 +0200
X-Gm-Features: AVHnY4JnZv4OcD3SWG0-ezGZp9mVo06bDbKUlEU9rVqZIh0c8vXY8Wv1R88hg_E
Message-ID: <CANNYZj9bFF__twkBcn+xPp-Tf+utqciW1b80c1L70XH6o_Ec1w@mail.gmail.com>
Subject: Re: [AUH][PATCH v2 4/9] upgrade-helper.py: add changelog flag
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org, paul@pbarker.dev, 
	ross.burton@arm.com, yoann.congal@smile.fr
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 27 Apr 2026 10:01:39 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3833

Can you add examples please? This implements three different
'strategies', all of them are doing 'guessing', so it would be really
beneficial to see what they actually produce.

It would also be super nice to have tests for this module, especially
if people start tweaking it further. It looks like something that can
break super easily. I know AUH has no tests (I inherited it in that
condition), but at least this particular part could.

Alex

On Fri, 24 Apr 2026 at 13:46, <daniel.turull@ericsson.com> wrote:
>
> From: Daniel Turull <daniel.turull@ericsson.com>
>
> Add --changelog option to extract git log between old and new versions,
> highlighting CVE references. The changelog summary is appended to the
> commit message and included in the email notification.
>
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
> Assisted-by: Claude, Anthropic
> ---
>  modules/changelog.py | 256 +++++++++++++++++++++++++++++++++++++++++++
>  modules/steps.py     |  20 ++++
>  upgrade-helper.py    |  16 +++
>  3 files changed, 292 insertions(+)
>  create mode 100644 modules/changelog.py
>
> diff --git a/modules/changelog.py b/modules/changelog.py
> new file mode 100644
> index 0000000..c1cc14b
> --- /dev/null
> +++ b/modules/changelog.py
> @@ -0,0 +1,256 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +import re
> +import glob
> +import functools
> +import subprocess
> +
> +from logging import info as I
> +from logging import debug as D
> +
> +import bb.utils
> +
> +CHANGELOG_FILENAMES = [
> +    'ChangeLog', 'CHANGELOG', 'CHANGELOG.md', 'CHANGELOG.txt',
> +    'Changes', 'CHANGES', 'NEWS', 'NEWS.md', 'NEWS.txt',
> +    'RELEASE_NOTES', 'RELEASE_NOTES.md', 'RELEASE-NOTES',
> +    'HISTORY', 'HISTORY.md',
> +    'debian/changelog',
> +]
> +
> +CVE_PATTERN = re.compile(r'(CVE-\d{4}-\d{4,})', re.IGNORECASE)
> +
> +
> +def _find_changelog_files(srcdir):
> +    found = []
> +    for name in CHANGELOG_FILENAMES:
> +        for f in glob.glob(os.path.join(srcdir, '**', name), recursive=True):
> +            if os.path.isfile(f) and f not in found:
> +                found.append(f)
> +    return found
> +
> +
> +RST_INCLUDE_RE = re.compile(r'^\.\.\s+include::\s+(.+)$')
> +RST_COMMENT_RE = re.compile(r'^\.\.\s*$|^\.\.\s')
> +
> +
> +def _strip_rst_comments(text):
> +    """Remove RST comment blocks (license headers etc.)."""
> +    lines = text.split('\n')
> +    result = []
> +    in_comment = False
> +    for line in lines:
> +        if RST_COMMENT_RE.match(line):
> +            in_comment = True
> +            continue
> +        if in_comment:
> +            if line.startswith('   ') or line.strip() == '':
> +                continue
> +            in_comment = False
> +        result.append(line)
> +    return '\n'.join(result)
> +
> +
> +def _resolve_rst_includes(content, base_dir, srcdir):
> +    """Inline RST .. include:: directives."""
> +    lines = content.split('\n')
> +    result = []
> +    for line in lines:
> +        m = RST_INCLUDE_RE.match(line.strip())
> +        if m:
> +            inc_rel = m.group(1).strip()
> +            inc_path = os.path.normpath(os.path.join(base_dir, inc_rel))
> +            if not os.path.isfile(inc_path):
> +                # Search for the filename within the source tree
> +                fname = os.path.basename(inc_rel)
> +                for f in glob.glob(os.path.join(srcdir, '**', fname),
> +                                   recursive=True):
> +                    if os.path.isfile(f):
> +                        inc_path = f
> +                        break
> +            if os.path.isfile(inc_path):
> +                try:
> +                    with open(inc_path, 'r', encoding='utf-8',
> +                              errors='replace') as f:
> +                        result.append(f.read())
> +                    continue
> +                except OSError:
> +                    pass
> +        result.append(line)
> +    return '\n'.join(result)
> +
> +
> +GIT_LOG_RE = re.compile(r'^commit [0-9a-f]{7,}', re.MULTILINE)
> +
> +
> +def _condense_git_log(text):
> +    """Condense git-log-style content to subject lines only."""
> +    if not GIT_LOG_RE.search(text):
> +        return text
> +    lines = text.split('\n')
> +    subjects = []
> +    i = 0
> +    while i < len(lines):
> +        if GIT_LOG_RE.match(lines[i]):
> +            short = lines[i].split()[1][:12]
> +            # Skip Author/Date, blank line, then grab subject
> +            i += 1
> +            while i < len(lines) and (lines[i].startswith('Author:') or
> +                    lines[i].startswith('Date:') or not lines[i].strip()):
> +                i += 1
> +            if i < len(lines):
> +                subjects.append('%s %s' % (short, lines[i].strip()))
> +            continue
> +        i += 1
> +    return '\n'.join(subjects) if subjects else text
> +
> +
> +def _extract_entries_between_versions(content, old_ver, new_ver):
> +    lines = content.split('\n')
> +    new_pattern = re.compile(re.escape(new_ver))
> +    old_pattern = re.compile(re.escape(old_ver))
> +
> +    start_idx = None
> +    end_idx = None
> +
> +    for i, line in enumerate(lines):
> +        if start_idx is None and new_pattern.search(line):
> +            start_idx = i
> +        elif start_idx is not None and old_pattern.search(line):
> +            end_idx = i
> +            break
> +
> +    if start_idx is not None:
> +        return '\n'.join(lines[start_idx:end_idx])
> +    return None
> +
> +
> +def _find_per_version_files(srcdir, old_ver, new_ver):
> +    """Find individual per-version changelog files (e.g. changelog-1.2.3.rst)."""
> +    ver_file_re = re.compile(
> +        r'(?:changelog|changes|news|release|relnotes)[-_./\\]?'
> +        r'v?(?P<pver>(\d+[\.\-_])*\d+)\.\w+$',
> +        re.IGNORECASE)
> +
> +    candidates = {}
> +    for f in glob.glob(os.path.join(srcdir, '**', '*'), recursive=True):
> +        if not os.path.isfile(f):
> +            continue
> +        # Match against last two path components (e.g. RelNotes/v1.47.4.txt)
> +        tail = os.sep.join(f.rsplit(os.sep, 2)[-2:])
> +        m = ver_file_re.search(tail)
> +        if m:
> +            ver = m.group('pver').replace('_', '.').replace('-', '.')
> +            candidates[ver] = f
> +
> +    # Select versions > old_ver and <= new_ver
> +    selected = []
> +    for ver, path in candidates.items():
> +        if bb.utils.vercmp_string(ver, old_ver) > 0 and \
> +           bb.utils.vercmp_string(ver, new_ver) <= 0:
> +            selected.append((ver, path))
> +
> +    selected.sort(key=lambda x: functools.cmp_to_key(
> +        bb.utils.vercmp_string)(x[0]))
> +    return [path for _, path in selected]
> +
> +
> +def extract_changelog(srcdir, pn, old_ver, new_ver, workdir):
> +    if not srcdir or not os.path.isdir(srcdir):
> +        D(" %s: source directory %s not available" % (pn, srcdir))
> +        return None
> +
> +    entries = []
> +    cves = []
> +
> +    # Strategy 1: extract sections between version markers in changelog files
> +    changelog_files = _find_changelog_files(srcdir)
> +    for fpath in changelog_files:
> +        try:
> +            with open(fpath, 'r', encoding='utf-8', errors='replace') as f:
> +                content = f.read()
> +        except OSError:
> +            continue
> +        content = _resolve_rst_includes(content, os.path.dirname(fpath), srcdir)
> +        section = _extract_entries_between_versions(content, old_ver, new_ver)
> +        if section:
> +            section = _condense_git_log(section)
> +            entries.append(section)
> +            cves.extend(CVE_PATTERN.findall(section))
> +            break
> +
> +    # Strategy 2: concatenate per-version files (e.g. changelog-9.18.42.rst)
> +    if not entries:
> +        ver_files = _find_per_version_files(srcdir, old_ver, new_ver)
> +        for fpath in ver_files:
> +            try:
> +                with open(fpath, 'r', encoding='utf-8', errors='replace') as f:
> +                    content = f.read()
> +            except OSError:
> +                continue
> +            entries.append(content)
> +            cves.extend(CVE_PATTERN.findall(content))
> +
> +    # Strategy 3: git log between version tags
> +    if not entries and os.path.isdir(os.path.join(srcdir, '.git')):
> +        tag_prefixes = ['v', '', pn + '-']
> +        old_tag = new_tag = None
> +        for prefix in tag_prefixes:
> +            try:
> +                subprocess.check_output(
> +                    ['git', 'rev-parse', prefix + old_ver],
> +                    cwd=srcdir, stderr=subprocess.DEVNULL)
> +                subprocess.check_output(
> +                    ['git', 'rev-parse', prefix + new_ver],
> +                    cwd=srcdir, stderr=subprocess.DEVNULL)
> +                old_tag, new_tag = prefix + old_ver, prefix + new_ver
> +                break
> +            except (subprocess.CalledProcessError, OSError):
> +                continue
> +        if old_tag and new_tag:
> +            try:
> +                out = subprocess.check_output(
> +                    ['git', 'log', '--oneline', '%s..%s' % (old_tag, new_tag)],
> +                    cwd=srcdir, stderr=subprocess.DEVNULL).decode('utf-8', errors='replace')
> +                if out.strip():
> +                    entries.append(out.strip())
> +                    cves.extend(CVE_PATTERN.findall(out))
> +            except (subprocess.CalledProcessError, OSError):
> +                pass
> +
> +    if not entries:
> +        D(" %s: no changelog entries found" % pn)
> +        return None
> +
> +    I(" %s: found %d changelog entries" % (pn, len(entries)))
> +
> +    cves = sorted(set(cves))
> +    text = "Changelog for %s: %s -> %s\n" % (pn, old_ver, new_ver)
> +    text += "=" * 60 + "\n\n"
> +    if cves:
> +        text += "SECURITY FIXES / CVEs FOUND:\n"
> +        for cve in cves:
> +            text += "  - %s\n" % cve
> +        text += "\n" + "-" * 60 + "\n\n"
> +    text += CVE_PATTERN.sub(r'*** \1 ***', _strip_rst_comments('\n\n'.join(entries)))
> +
> +    # Collapse multiple blank lines into one
> +    text = re.sub(r'\n{3,}', '\n\n', text)
> +
> +    changelog_path = os.path.join(workdir, "changelog-%s.txt" % pn)
> +    with open(changelog_path, 'w', encoding='utf-8') as f:
> +        f.write(text)
> +
> +    I(" %s: changelog saved to %s" % (pn, os.path.basename(changelog_path)))
> +    if cves:
> +        I(" %s: CVEs found: %s" % (pn, ', '.join(cves)))
> +
> +    commit_text = text
> +    if len(commit_text) > 3000:
> +        commit_text = commit_text[:3000] + "\n\n[... changelog truncated ...]\n"
> +    # Sanitize for shell-safe git commit -m "..."
> +    for ch in '"', '`', '$', '\\':
> +        commit_text = commit_text.replace(ch, '')
> +
> +    return {'text': text, 'commit_text': commit_text, 'cves': cves, 'file': changelog_path}
> diff --git a/modules/steps.py b/modules/steps.py
> index b3ec61c..78fcbbe 100644
> --- a/modules/steps.py
> +++ b/modules/steps.py
> @@ -29,6 +29,7 @@ from logging import warning as W
>
>  from errors import Error, DevtoolError, CompilationError
>  from buildhistory import BuildHistory
> +from changelog import extract_changelog
>
>  def load_env(devtool, bb, git, opts, group):
>      group['workdir'] = os.path.join(group['base_dir'], group['name'])
> @@ -150,10 +151,29 @@ def devtool_finish(devtool, bb, git, opts, group):
>              pass
>          raise e1
>
> +def changelog_extract(devtool, bb, git, opts, group):
> +    if not opts.get('changelog'):
> +        return
> +    for p in group['pkgs']:
> +        # After devtool_upgrade, source is in workspace/sources/<pn>/
> +        srcdir = os.path.join(os.environ.get('BUILDDIR', ''),
> +                              'workspace', 'sources', p['PN'])
> +        if not os.path.isdir(srcdir):
> +            # Fallback: derive from env S, replacing old version
> +            srcdir = p['env'].get('S', '')
> +            if p['PV'] in srcdir:
> +                srcdir = srcdir.replace(p['PV'], p['NPV'])
> +        result = extract_changelog(srcdir, p['PN'], p['PV'],
> +                                   p['NPV'], group['workdir'])
> +        if result:
> +            p['changelog'] = result
> +            group['commit_msg'] += "\n\n" + result['commit_text']
> +
>  upgrade_steps = [
>      (load_env, "Loading environment ..."),
>      (buildhistory_init, None),
>      (devtool_upgrade, "Running 'devtool upgrade' ..."),
> +    (changelog_extract, "Extracting changelog ..."),
>      (devtool_finish, "Running 'devtool finish' ..."),
>      (compile, None),
>  ]
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index df927d1..327bb6d 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -95,6 +95,8 @@ def parse_cmdline():
>
>      parser.add_argument("-t", "--to_version",
>                          help="version to upgrade the recipe to")
> +    parser.add_argument("--changelog", action="store_true", default=False,
> +                        help="extract changelog between old and new versions, highlighting CVEs")
>
>      parser.add_argument("-d", "--debug-level", type=int, default=4, choices=range(1, 6),
>                          help="set the debug level: CRITICAL=1, ERROR=2, WARNING=3, INFO=4, DEBUG=5")
> @@ -198,6 +200,7 @@ class Updater(object):
>          self.opts['skip_compilation'] = self.args.skip_compilation
>          self.opts['buildhistory'] = self._buildhistory_is_enabled()
>          self.opts['testimage'] = self._testimage_is_enabled()
> +        self.opts['changelog'] = self.args.changelog
>
>      def _make_dirs(self, build_dir):
>          self.uh_dir = os.path.join(build_dir, "upgrade-helper")
> @@ -358,6 +361,19 @@ class Updater(object):
>          if 'patch_file' in g and g['patch_file'] is not None:
>              msg_body += next_steps_info % (os.path.basename(g['patch_file']))
>
> +        # Add changelog summary if available
> +        for pkg_ctx in g['pkgs']:
> +            if 'changelog' in pkg_ctx:
> +                cl = pkg_ctx['changelog']
> +                msg_body += ("\n--- Changelog Summary for %s ---\n"
> +                             % pkg_ctx['PN'])
> +                if cl['cves']:
> +                    msg_body += "\nSECURITY FIXES / CVEs:\n"
> +                    for cve in cl['cves']:
> +                        msg_body += "  - %s\n" % cve
> +                    msg_body += "\n"
> +                msg_body += cl['text'] + "\n"
> +
>          msg_body += mail_footer
>
>          # Add possible attachments to email
> --
> 2.34.1
>

