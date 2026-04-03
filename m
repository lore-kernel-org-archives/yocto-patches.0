Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29E8E8539C
	for <webhook@archiver.kernel.org>; Fri,  3 Apr 2026 18:37:06 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2224.1775241421732221663
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 03 Apr 2026 11:37:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZhRhUS/7;
 spf=pass (domain: gmail.com, ip: 209.85.222.177, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb40149037so249130985a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 11:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241420; x=1775846220; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvIzeK+Q0TjrqF2DnXAmJL/sIx/KZGF+I3wDLt06Doo=;
        b=ZhRhUS/7IUCjfGTa/l1Ak+fGByEj/pQThYxm+/x/p8TCndX+SWNImjCi3OvEvsx3bo
         Bskgpw3kVb9YM5Gey1ysqF5EKNy5ulLXTx5qrku6B6+z60vwm12twKxNu0B3DokG2MI4
         ldZcvIWnLLS02DMjqzz8L+eT4YNnTKD/V8NmuyQBwh2e6ToxSMscONIKnWGUrwOzBc22
         R4GIBdYBhZ09dwwoWoYmswXC45swkDkhjKMGmdkhXzvB7Q+DkGRg1QYO969iU98pXlIF
         QK7DKaSiGGYYc+BWfhCM8rZTcx3h+mglymxiqsAfoUKuqyBsCZ3iPCkBD1Wr9kaOa+kQ
         fjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241420; x=1775846220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YvIzeK+Q0TjrqF2DnXAmJL/sIx/KZGF+I3wDLt06Doo=;
        b=oSm/v8ARTWZHoOrq812fr/5/hoMlEJ6ZswznG77EoZ5lkHk52pIzFGnIiW3Y2dzXIY
         3ouEDwZwhKtZAh90ywK8TZOWM2bUC/q/zB4zlFlakQfF4wqY1GSbO/xyTeQWHm01QiyZ
         eL80ZVLejvYpLWN9jaiCn6E1W0Z5M5UFGCNrnklIqiPljlpKpMxM1FN8AIuXF+fc8Mjt
         mAnSnCsvQ2ckHjhvLoApT5YFaIH6p0fPlDWIWB0Mo3MiQWriDhn5oiznVIOYmnYU8o+b
         8VUuW4pD/cFIZqDdd6kItSF73vASTkgggoVRq16R09m+pGG5yl9qMGQQJVICeGH4aQqZ
         HXwg==
X-Gm-Message-State: AOJu0YzoSZ6aWBm4xumHgZ4VPoO70sfC3WYU7HeKvGYh2/UD8W6+zgsR
	dL9UCvu3jQXFuHGgEj++31lmHR5DPbxGeGC0/VrEreWJVhO4BsvNQRcDdwl8nk3V
X-Gm-Gg: ATEYQzxb/8F2PfK6xSYdoX0cFLWG+XHhb61AgTMLsELc2TnolYLzGvj9hYH1JeF2wR4
	TLwA8Ce3MN05407QoMBIAVeTMDc9FQx5fxODP3a7BMEZSEIocEaZj66/jAW8j13aVh6QoMq3YAk
	WgoewNgKFwMZqQYBmey6zoWLmeTj0ZDtvgLLmSXrHfCSnmOTLLqiP5ANQTnWqPVf9viF51TVvmg
	Naidtk/Y5s5l8jAAR7F77z3KF77AF5SXUOlecP4NJW1PwpaoSaa/f6eFGRtEp28JkqpqlLvNte+
	SCF6mRxYC1qcEOZgIBxuG7yzpNtKcUB7NaNVk7GP5CeQykRc5vHOM0XEXcrAVifbpxs4wJi/CAS
	N+Rq4p+pkSrEnc84yO1pOi/BIRq9ZF+1d218rAY+mr2eTAJwamufm6p5lS0UgWpp/NbMhfJ9u0w
	UzyGlwQa76613LhPZNp7GQ8I2xImvTwrnGhzyP6haf1cJ5hMHRf+mL8wdQDG/Apsacqg==
X-Received: by 2002:a05:620a:2981:b0:8cd:9322:d449 with SMTP id af79cd13be357-8d41e340605mr577805885a.56.1775241419624;
        Fri, 03 Apr 2026 11:36:59 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a874459asm472401785a.39.2026.04.03.11.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:36:59 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Mark Hatle <mark.hatle@kernel.crashing.org>
Subject: [wic][PATCH 3/9] create python hatch project
Date: Fri,  3 Apr 2026 14:36:38 -0400
Message-ID: <20260403183644.2783267-4-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260403183644.2783267-1-twoerner@gmail.com>
References: <20260403183644.2783267-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 03 Apr 2026 18:37:06 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3629

Add the pieces necessary to convert this project into a standard Python
hatch package.

NOTE: this commit does not work as-is, but is being provided in order to
      explicitly show a clean transition from oe-core

Reviewed-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .gitignore     |   1 +
 LICENSE        | 288 +++++++++++++++++++++++++++++++++++++++++++++++++
 README.md      |  51 +++++++++
 pyproject.toml |  38 +++++++
 4 files changed, 378 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 LICENSE
 create mode 100644 README.md
 create mode 100644 pyproject.toml

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 000000000000..eeb8a6ec4087
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1 @@
+**/__pycache__
diff --git a/LICENSE b/LICENSE
new file mode 100644
index 000000000000..5db3c0a21cdb
--- /dev/null
+++ b/LICENSE
@@ -0,0 +1,288 @@
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
+ 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Lesser General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+Note:
+Individual files contain the following tag instead of the full license text.
+
+    SPDX-License-Identifier: GPL-2.0-only
+
+This enables machine processing of license information based on the SPDX
+License Identifiers that are here available: http://spdx.org/licenses/
diff --git a/README.md b/README.md
new file mode 100644
index 000000000000..8ee02d89738b
--- /dev/null
+++ b/README.md
@@ -0,0 +1,51 @@
+# WIC Standalone
+
+This packages the OpenEmbedded Image Creator (`wic`) as an installable
+Python CLI using Hatch. It either consumes BitBake-exported environment
+files (generated via `bitbake -c rootfs_wicenv <image>`) or will invoke
+BitBake directly (if available on the PATH).
+
+## Quick start
+
+### Using wicenv
+1. Ensure you have a BitBake-generated `<image>.env` file (from `rootfs_wicenv`).
+2. Install locally for development:
+   ```bash
+   hatch shell
+   ```
+3. Run the CLI:
+   ```bash
+   hatch run wic --vars /path/to/<image>.env --help
+   ```
+
+### With bitbake
+1. Ensure you have bitbake available in your PATH.
+2. Install locally for development:
+   ```bash
+   hatch shell
+   ```
+3. Run the CLI:
+   ```bash
+   hatch run wic --help
+   ```
+
+## Project layout
+
+- `src/wic/cli.py`: CLI entrypoint (formerly `scripts/wic`).
+- `src/wic/*`: core engine, plugins, and helpers.
+- `src/bb/*`: various bitbake helpers that were brought along and used in other parts of wic.
+- `src/oe/*`: various oe-core helpers that were brought along and used in other parts of wic.
+
+## Contributing
+
+Please send all patches, comments, or questions to the yocto-patches
+mailing list (yocto-patches@lists.yoctoproject.org).
+See https://lists.yoctoproject.org/g/yocto-patches
+
+When sending patches, please make sure the email subject line includes
+"[wic][PATCH]" and follow The Yocto Project community's patch submission
+guidelines.
+
+## Licensing
+
+GPL-2.0-only to match the original OpenEmbedded wic tooling.
diff --git a/pyproject.toml b/pyproject.toml
new file mode 100644
index 000000000000..fdc1ce0f5ece
--- /dev/null
+++ b/pyproject.toml
@@ -0,0 +1,38 @@
+[project]
+name = "wic"
+description = "OpenEmbedded Image Creator (wic) packaged as a standalone CLI"
+dynamic = ["version"]
+readme = "README.md"
+license = { text = "GPL-2.0-only" }
+maintainers = [
+    { name = "Trevor Woerner", email = "twoerner@gmail.com" },
+]
+requires-python = ">=3.8"
+classifiers = [
+  "Intended Audience :: Developers",
+  "Topic :: Software Development :: Build Tools",
+  "Topic :: Software Development :: Embedded Systems",
+  "License :: OSI Approved :: GNU General Public License v2 (GPLv2)",
+  "Programming Language :: Python",
+  "Programming Language :: Python :: 3",
+]
+
+[project.urls]
+Homepage = "https://git.yoctoproject.org/wic"
+Repository = "https://git.yoctoproject.org/wic"
+
+[project.scripts]
+wic = "wic.cli:main"
+
+[tool.hatch.build]
+packages = ["src/wic"]
+
+[tool.hatch.build.targets.wheel]
+packages = ["src/wic"]
+
+[build-system]
+requires = ["hatchling>=1.21"]
+build-backend = "hatchling.build"
+
+[tool.hatch.version]
+path = "src/wic/cli.py"
-- 
2.51.0


