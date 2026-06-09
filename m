Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715A1CD6E79
	for <webhook@archiver.kernel.org>; Tue,  9 Jun 2026 09:52:18 +0000 (UTC)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.75814.1780998737276263851
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 09 Jun 2026 02:52:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=dv/2e4B4;
 spf=pass (domain: gmail.com, ip: 209.85.219.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ce0f17a69cso40185536d6.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 02:52:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780998736; cv=none;
        d=google.com; s=arc-20240605;
        b=ZjuEMhEQIsTb5+FJbrOCoeGWMx5tdysZDzNjQBuhNTRtUMY95KSsVPJgnbLerHsLUO
         xD5uXbnky6ui+s35uR6zoK4QwrSbc000cl1aZC9t6DkgmgmTiSAaPaJefNzZGoIFgP3A
         7zlad2K+xoZ+scrgGjYcj5XkqPwJ829faze1pkoBJY7QKVzsKJMnLmYg7lT7h5u3S7eq
         7oDWaQ+LXqb8gogOC2cTdpS7px3YGt58zLHgG7PtoSgJ7zgaWpaKW5XXE3+QVmkYOSVz
         FWtKu6+4bmbImlE0AO5cXcCdVDHvl/sZCTWymc+Gxbc3W97WBne9mX0R0zRO5cKB05bf
         bQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=n1jrBlq3umahQMIAunOAkY7shLLsIcWhcMK1LSXHgEw=;
        fh=28JQhdK5h5mLF5DLv2fLR8YFHEF0yTvH5opUNnJ6Zzo=;
        b=MvHLv00/xFgl8qLQLKOpH5wbLdksaYEht+ji19ganFV9stuOEcK12yLADoLrA1alPX
         4AmYGLbJebTlMpQHtljTBMqiYz90NEeoVWp/rbMVkXm/jssZW2JblHLv87AxU+7u7ZIB
         4szojBK8ib/6rJKYCc0TOAdtds742z+gaAL79Ri/fv8rzwsmYCaWVKS2uVjFRth3FvpS
         Lpm6GljE33Xm0/YQ+eY0j7JDIcnReGgN4VkDyaSi1MI1L7PUSqe+zfOJFERUKEOlvG5V
         hRVlvspOCPnvkD9KX/ASQUGsjbq2QSmjmGdQzmZ/t5Iu4+R8OSVX8WrBSFR0e0wpwLMt
         rcww==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780998736; x=1781603536; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n1jrBlq3umahQMIAunOAkY7shLLsIcWhcMK1LSXHgEw=;
        b=dv/2e4B4A2W2ombMOtpZ0iS85qL/8NaNYAC0+Mu7lIoIlqkyaZMDPkJ+8y7yUr5tnT
         RsTSUZE4akQkB/H6mdIa/jxGw0Jv2cg8wn5KRlketQexPLGTztQu26ZZKWS4ECqlLIXq
         8/Q7z6TdPbkFKLtO4vp56BP1YdBmWAQnhB8gnRNhoPtE9ekNHh1+Ab23dXrFnJqK6Fv/
         Bi4C50c/2LxbYcqauZzGvE98ytXNvKCJWIIB/btfnv52aNFP1/WPmEe0XZwxxTZ95UrS
         coMbyBbOqgDJFEwzeY8/fbIlnuEft+NfExsJRx1VYwkORXSk6D92n9dJxhlhDa5SMQYt
         sYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998736; x=1781603536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1jrBlq3umahQMIAunOAkY7shLLsIcWhcMK1LSXHgEw=;
        b=CKyxSkY1J9jGWbrgl/NVMZgYjQK6ZWN7sM6W7+dW9yLq08VD0pslz9HYzPY13RFh3q
         sjwO8uZx+3VmuggKHahS9T1MrBRSiIcmny74BcAf2zng2lGwEeNE4iITleyheEMMiX23
         gaNOt6OhzQ9CAwAznMqM7Rtz15V5dVc5jKKS47nMnGx+nBLETWfZuBeTzKlOOxNpUO97
         QtZnq4FA9XZhl0kqz8sSG+P/QI373eSIqfZlkUEZVtZKCaifzxCKi2dswSxSz+kr7RLT
         llfnieDMyA9RP8GIH6FAfU7m1fHZgYk4fCq7iscXquo9BbPk7WeVg+geM/yRZZ4BAGaz
         rBGw==
X-Gm-Message-State: AOJu0YwP70rHrL/oaorchoRuvWUDOm9PW5L+RKz190zFPlyqAaXEZWL2
	Mpkag+gQvF77Dvgac2lY4kHem68SYbLowXuB7+c9UYzr7NsS//sgW7gZMpvJknkF3Rw3AKW8z4b
	3n4Q5iD96fIuGYPDariYI5Pl3NlBrLjQv4w==
X-Gm-Gg: Acq92OFPKQeq8DB4SA1iZ59rmbYnGSCdJ1n3YyfKi7CzTrUn09m3kf1H+utDIfUOCVQ
	nFKMuiBht9TO/VxaWz89A3VkHkDBnfQgOoB4yQmghd3ZTKxqBUIaP4akX+l64cuSIkflOwaNE+v
	7dPBoeqYyRkPr14u2QgrvEnPoBGLBnEtvOe3hI1cug4auwCd8Sf3g65DE2p1lqn5FIbagBg05Jd
	K2u/uS1/1KAL9GXca1+LY7PiH3FM//Gb92NT5VeWxgH8LnF8EusMkwNGFdPuCjU7QYy5+khlgJj
	s01gaqSGK5kpnBVU0NE=
X-Received: by 2002:a0c:fb0f:0:b0:8cc:f0b9:1f3b with SMTP id
 6a1803df08f44-8cee5ff3b4emr230898626d6.20.1780998736100; Tue, 09 Jun 2026
 02:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260605132739.617143-1-daniel.turull@ericsson.com>
In-Reply-To: <20260605132739.617143-1-daniel.turull@ericsson.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 9 Jun 2026 11:52:06 +0200
X-Gm-Features: AVVi8CcLeuiezmk4nrrs4lkS51zrVEsAWCwygEFty6oPOZ5iDHBfHMtmuwpIgos
Message-ID: <CANNYZj-okUKGLMSE2gbgX5U8nNrbhE9n0bxctC3qywcfxwc8YQ@mail.gmail.com>
Subject: Re: [AUH] [PATCH v3] upgrade-helper: add state module and
 --incremental mode
To: daniel.turull@ericsson.com
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 09 Jun 2026 09:52:18 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4184

Thanks, this has been merged. I've also posted patches that tweak the
autobuilder to take the incremental updates into daily use. Once they
merge, let's run it for a few days to see that it operates correctly,
then we can add the changelog support.

Alex

On Fri, 5 Jun 2026 at 15:28, <daniel.turull@ericsson.com> wrote:
>
> From: Daniel Turull <daniel.turull@ericsson.com>
>
> Without this, every AUH run retries all candidates regardless of previous
> outcomes, wasting time on recipes that consistently fail or were already
> upgraded recently.
>
> Add modules/state.py which persists upgrade results to a JSON state file
> (auh-state.json in the upgrade-helper work directory, typically
> $BUILDDIR/upgrade-helper/). The new --incremental flag activates this
> tracking and skips package groups where all packages were recently attempted.
>
> Behavior:
> - Failed attempts are retried after retry_same_version_interval days
>   (default 30).
> - Successful/already-current upgrades are suppressed for success_max_age
>   days (default 30).
> - Rapid-fire recipes (listed in retry_any_version_recipes) are throttled
>   by retry_any_version_interval (default 7) regardless of version or
>   result, preventing mailing list flooding from recipes with very frequent
>   upstream releases.
>
> Tested with master (2026-06-01):
> command: ../auto-upgrade-helper/upgrade-helper.py all --incremental -s
>
> - Run 1 (2026-06-01 07:38): 122 attempted, 98 succeeded, 24 failed, 0 skipped
> - Run 2 (2026-06-01 11:17): 1 attempted, 0 succeeded, 1 failed, 26 skipped
> - Run 3 (2026-06-01 11:20): 0 attempted, 0 succeeded, 0 failed, 27 skipped
>
> 2nd test on master (2026-06-02)
>
> Now in the second run we get the skipping message
>
> INFO: piglit 1.0-new-commits-available: skipping (last attempt 2026-06-02 13:38:01 result=failure; will retry in 30 day(s))
> INFO: libinput 1.31.2: skipping (last attempt 2026-06-02 13:40:03 result=failure; will retry in 30 day(s))
> INFO: alsa-ucm-conf 1.2.16: skipping (last attempt 2026-06-02 13:43:57 result=failure; will retry in 30 day(s))
> INFO: webkitgtk 2.52.4: skipping (last attempt 2026-06-02 13:46:52 result=failure; will retry in 30 day(s))
> INFO: boost 1.91.0: skipping (last attempt 2026-06-02 13:50:11 result=failure; will retry in 30 day(s))
> INFO: libical 4.0.2: skipping (last attempt 2026-06-02 13:52:44 result=failure; will retry in 30 day(s))
> INFO: vte 0.84.0: skipping (last attempt 2026-06-02 13:53:31 result=failure; will retry in 30 day(s))
> INFO: 28/28 package groups skipped (incremental mode)
> Link: https://lists.openembedded.org/g/openembedded-architecture/message/2349
>
> And extract of auh-state.json
>
>     "cargo": {
>       "1.96.0": {
>         "timestamp": 1780405831.0888734,
>         "result": "failure"
>       }
>     },
>     "sbom-cve-check-update-cvelist-native": {
>       "2026-06-02": {
>         "timestamp": 1780406109.500104,
>         "result": "success"
>       }
>     },
>
> AI-Generated: kiro with claude-opus-4.6 model
> Signed-off-by: Daniel Turull <daniel.turull@ericsson.com>
>
> ---
> Changes in v3:
> - Rename retry_interval to retry_same_version_interval
> - Add retry_any_version_interval (default 7 days) for rapid-fire recipes
> - Add retry_any_version_recipes config setting (space-separated list)
> - Unify timestamp logic into a single check() helper returning
>   {skip, reason}; should_skip(), skip_reason() and _prune() all
>   derive from it
>
> Changes in v2:
> - should_skip() simplified to a presence check; _prune() owns all time logic
> - log skip reason (previous timestamp, result, days until retry) per group
> - log recorded result per package after each attempt
> - drop upgrade_err capture; use g['error'] directly after commit_changes()
> - drop dead isinstance(upgrade_err, UpgradeNotNeededError) check
> ---
>  modules/state.py    | 140 ++++++++++++++++++++++++++++++++++++++++++++
>  upgrade-helper.conf |  21 ++++++-
>  upgrade-helper.py   |  46 +++++++++++++++
>  3 files changed, 206 insertions(+), 1 deletion(-)
>  create mode 100644 modules/state.py
>
> diff --git a/modules/state.py b/modules/state.py
> new file mode 100644
> index 0000000..0c2c7bb
> --- /dev/null
> +++ b/modules/state.py
> @@ -0,0 +1,140 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# vim: set ts=4 sw=4 et:
> +#
> +# Copyright (c) 2026 Ericsson AB
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License
> +# as published by the Free Software Foundation; either version 2
> +# of the License, or (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write to the Free Software
> +# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> +#
> +# AUTHORS
> +# Daniel Turull   <daniel.turull@ericsson.com>
> +#
> +
> +import datetime
> +import json
> +import os
> +import time
> +
> +from logging import warning as W
> +
> +RESULT_SUCCESS = "success"
> +RESULT_FAILURE = "failure"
> +
> +STATE_FILENAME = "auh-state.json"
> +STATE_VERSION = 1
> +
> +SECONDS_PER_DAY = 86400
> +DEFAULT_RETRY_SAME_VERSION_DAYS = 30
> +DEFAULT_RETRY_ANY_VERSION_DAYS = 7
> +DEFAULT_SUCCESS_MAX_AGE_DAYS = 30
> +
> +
> +class State:
> +    """Tracks upgrade attempts as {recipe: {version: {timestamp, result}}}."""
> +
> +    def __init__(self, state_dir,
> +                 retry_same_version_days=DEFAULT_RETRY_SAME_VERSION_DAYS,
> +                 success_max_age_days=DEFAULT_SUCCESS_MAX_AGE_DAYS,
> +                 retry_any_version_days=DEFAULT_RETRY_ANY_VERSION_DAYS,
> +                 retry_any_version_recipes=None):
> +        self.path = os.path.join(state_dir, STATE_FILENAME)
> +        self.retry_same_version = retry_same_version_days * SECONDS_PER_DAY
> +        self.success_max_age = success_max_age_days * SECONDS_PER_DAY
> +        self.retry_any_version = retry_any_version_days * SECONDS_PER_DAY
> +        self.any_version_recipes = set(retry_any_version_recipes or [])
> +        self.data = self._load()
> +        self._prune()
> +
> +    def _load(self):
> +        if os.path.exists(self.path):
> +            try:
> +                with open(self.path) as f:
> +                    raw = json.load(f)
> +            except (json.JSONDecodeError, OSError) as e:
> +                W(" %s is corrupt (%s), starting fresh" % (self.path, e))
> +                return {}
> +            if not isinstance(raw, dict) or raw.get("version") != STATE_VERSION:
> +                W(" %s: unsupported or missing version, starting fresh"
> +                  % self.path)
> +                return {}
> +            return raw.get("recipes", {})
> +        return {}
> +
> +    def save(self):
> +        with open(self.path, "w") as f:
> +            json.dump({"version": STATE_VERSION, "recipes": self.data},
> +                      f, indent=2)
> +
> +    def record(self, pn, version, result):
> +        entry = {"timestamp": time.time(), "result": result}
> +        if pn not in self.data:
> +            self.data[pn] = {}
> +        self.data[pn][version] = entry
> +
> +    def should_skip(self, pn, version):
> +        """Return True if this recipe/version should not be attempted."""
> +        return self.check(pn, version)['skip']
> +
> +    def skip_reason(self, pn, version):
> +        """Return a human-readable string explaining why pn/version is being skipped."""
> +        return self.check(pn, version)['reason']
> +
> +    def check(self, pn, version):
> +        """Return {'skip': bool, 'reason': str} for a recipe/version pair.
> +
> +        For any_version_recipes, any recent attempt (any version) causes a skip.
> +        For normal recipes, only a matching version entry causes a skip.
> +        """
> +        if pn in self.any_version_recipes:
> +            entry = self._newest_entry(pn)
> +            max_age = self.retry_any_version
> +        else:
> +            entry = self.data.get(pn, {}).get(version)
> +            if entry is None:
> +                return {'skip': False, 'reason': ''}
> +            max_age = self.success_max_age \
> +                if entry.get("result") == RESULT_SUCCESS \
> +                else self.retry_same_version
> +
> +        if not entry:
> +            return {'skip': False, 'reason': ''}
> +
> +        ts = entry.get("timestamp", 0)
> +        age = time.time() - ts
> +        if age > max_age:
> +            return {'skip': False, 'reason': ''}
> +
> +        result = entry.get("result", "unknown")
> +        when = datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H:%M:%S")
> +        retry_in = int((max_age - age) / SECONDS_PER_DAY) + 1
> +        prefix = "rapid-fire; " if pn in self.any_version_recipes else ""
> +        return {'skip': True,
> +                'reason': "%slast attempt %s result=%s; will retry in %d day(s)"
> +                          % (prefix, when, result, retry_in)}
> +
> +    def _newest_entry(self, pn):
> +        """Return the most recent entry for a recipe across all versions."""
> +        versions = self.data.get(pn, {})
> +        return max(versions.values(), key=lambda e: e.get("timestamp", 0),
> +                   default={})
> +
> +    def _prune(self):
> +        """Remove entries that check() would no longer skip."""
> +        for pn in list(self.data):
> +            versions = self.data[pn]
> +            for ver in list(versions):
> +                if not self.check(pn, ver)['skip']:
> +                    del versions[ver]
> +            if not versions:
> +                del self.data[pn]
> diff --git a/upgrade-helper.conf b/upgrade-helper.conf
> index 269bde3..53c3c46 100644
> --- a/upgrade-helper.conf
> +++ b/upgrade-helper.conf
> @@ -50,7 +50,26 @@
>  # passed; does not apply when layer_mode is enabled).
>  #blacklist=python glibc gcc
>
> -# specify the directory where work (patches) will be saved
> +# When running with --incremental, how many days to wait before retrying
> +# a failed upgrade attempt for the same recipe version. Default is 30 days.
> +#retry_same_version_interval=30
> +
> +# When running with --incremental, how many days to skip a successfully
> +# upgraded recipe version before attempting it again. Default is 30 days.
> +#success_max_age=30
> +
> +# When running with --incremental, how many days to suppress any upgrade
> +# attempt for recipes listed in retry_any_version_recipes, regardless of
> +# version or result. Useful for recipes with very frequent upstream releases.
> +# Default is 7 days.
> +#retry_any_version_interval=7
> +
> +# Space-separated list of recipes that release so frequently that they would
> +# flood the mailing list. These are throttled by retry_any_version_interval
> +# instead of per-version intervals.
> +#retry_any_version_recipes=vulkan-samples sbom-cve-check-update-cvelist-native sbom-cve-check-update-nvd-native
> +
> +# specify the directory where work (patches) will be saved
>  # (optional; default is BUILDDIR/upgrade-helper/)
>  #workdir=
>
> diff --git a/upgrade-helper.py b/upgrade-helper.py
> index 4786735..fb9e45f 100755
> --- a/upgrade-helper.py
> +++ b/upgrade-helper.py
> @@ -59,6 +59,10 @@ from utils.emailhandler import Email
>  from statistics import Statistics
>  from steps import upgrade_steps
>  from testimage import TestImage
> +from state import (State, RESULT_SUCCESS, RESULT_FAILURE,
> +                   DEFAULT_RETRY_SAME_VERSION_DAYS,
> +                   DEFAULT_RETRY_ANY_VERSION_DAYS,
> +                   DEFAULT_SUCCESS_MAX_AGE_DAYS)
>
>  if not os.getenv('BUILDDIR', False):
>      E(" You must source oe-init-build-env before running this script!\n")
> @@ -104,6 +108,8 @@ def parse_cmdline():
>                          help="do not compile, just change the checksums, remove PR, and commit")
>      parser.add_argument("-c", "--config-file", default=None,
>                          help="Path to the configuration file. Default is $BUILDDIR/upgrade-helper/upgrade-helper.conf")
> +    parser.add_argument("--incremental", action="store_true",
> +                        help="skip recipes already attempted (uses JSON state file)")
>      parser.add_argument("--layer-names", nargs='*', action="store", default='',
>                          help="layers to include in the upgrade research")
>      parser.add_argument("--layer-dir", action="store", default='',
> @@ -169,6 +175,22 @@ class Updater(object):
>              self.email_handler = Email(settings)
>          self.statistics = Statistics()
>
> +        if self.args.incremental:
> +            retry_same = int(settings.get('retry_same_version_interval',
> +                                          DEFAULT_RETRY_SAME_VERSION_DAYS))
> +            success_max_age = int(settings.get('success_max_age',
> +                                               DEFAULT_SUCCESS_MAX_AGE_DAYS))
> +            retry_any = int(settings.get('retry_any_version_interval',
> +                                         DEFAULT_RETRY_ANY_VERSION_DAYS))
> +            any_version_recipes = settings.get('retry_any_version_recipes', '').split()
> +            self.state = State(self.uh_dir,
> +                               retry_same_version_days=retry_same,
> +                               success_max_age_days=success_max_age,
> +                               retry_any_version_days=retry_any,
> +                               retry_any_version_recipes=any_version_recipes)
> +        else:
> +            self.state = None
> +
>      def _set_options(self):
>          self.opts = {}
>          self.opts['layer_mode'] = settings.get('layer_mode', '')
> @@ -468,6 +490,19 @@ class Updater(object):
>
>              pkggroups_ctx.append({"name":",".join([pkg_ctx['PN'] for pkg_ctx in pkgs_ctx]),"pkgs":pkgs_ctx,"error":None, 'base_dir':self.uh_recipes_all_dir})
>          I(" ############################################################")
> +        if self.state:
> +            kept = []
> +            for g in pkggroups_ctx:
> +                pn, npv = g['pkgs'][0]['PN'], g['pkgs'][0]['NPV']
> +                r = self.state.check(pn, npv)
> +                if r['skip']:
> +                    I(" %s %s: skipping (%s)" % (pn, npv, r['reason']))
> +                else:
> +                    kept.append(g)
> +            I(" %d/%d package groups skipped (incremental mode)"
> +              % (len(pkggroups_ctx) - len(kept), len(pkggroups_ctx)))
> +            pkggroups_ctx = kept
> +            total_pkggroups = len(pkggroups_ctx)
>          if pkggroups_ctx and not self.args.skip_compilation:
>              I(" Building gcc runtimes ...")
>              for machine in self.opts['machines']:
> @@ -532,6 +567,17 @@ class Updater(object):
>                      succeeded_pkggroups_ctx.remove(g)
>                      failed_pkggroups_ctx.append(g)
>
> +            if self.state:
> +                result = RESULT_FAILURE if g.get('error') else RESULT_SUCCESS
> +                # All packages in a group share the same result because AUH
> +                # upgrades them atomically; individual outcomes are not tracked.
> +                for pkg_ctx in g['pkgs']:
> +                    I(" %s %s: recording result=%s" % (pkg_ctx['PN'], pkg_ctx['NPV'], result))
> +                    self.state.record(pkg_ctx['PN'], pkg_ctx['NPV'], result)
> +
> +        if self.state:
> +            self.state.save()
> +
>          if self.opts['testimage']:
>              ctxs = {}
>              ctxs['succeeded'] = succeeded_pkggroups_ctx
> --
> 2.51.0
>

