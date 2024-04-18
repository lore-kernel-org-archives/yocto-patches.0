Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.8836.1713433773406377745
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 18 Apr 2024 02:49:34 -0700
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-418effbc70cso1560045e9.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 18 Apr 2024 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thehoodiefirm-com.20230601.gappssmtp.com; s=20230601; t=1713433772; x=1714038572; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H1wP7SNeqOwGUrKThjbJdJNmgq1a5k/fJ6Z2OO9liHA=;
        b=ZcGyJgbmzr3TZSM5oa2yEji4wdwB668vilHtVqATVXEw2pLLZwFRKYWATuhEqRk+r3
         86rpB+/SDdhBOAVKi0K8c+uNqjudgpIRRmFJkngFujaiM7wDo5Vo+BXCqigyCaX4aXyB
         71HZeSIWQjlb3B+8/yiMMXNip1l4F6W3BVt+aehAq3rwndLa2Nh6oofdyi4EIazJWpFq
         F+7j9Erq45gMhlohfV11erWbhjojKxER/zhEU0wIHasT7/NB0Ooc9gdjK/9IJOCL6vsY
         zf5XEZinLq1aGdnB5uoQpI1mRL3zLsy4oq6HACVu/AMesi/K4sM4Z1hKR69DJJWd0dGL
         D1lA==
Return-Path: <ninette@thehoodiefirm.com>
From: "Ninette Adhikari" <ninette@thehoodiefirm.com>
Subject: [PATCH 2/4] patch-status/index.html: use pico.css
Date: Thu, 18 Apr 2024 11:49:15 +0200
Message-ID: <20240418094921.86489-6-ninette@thehoodiefirm.com>
In-Reply-To: <20240418094921.86489-1-ninette@thehoodiefirm.com>
References: <20240418094921.86489-1-ninette@thehoodiefirm.com>
Reply-To: engineering@neighbourhood.ie
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable
To: yocto-patches@lists.yoctoproject.org
Cc: engineering@neighbourhood.ie, hulkoba <jacoba@neighbourhood.ie>
List-ID: <yocto-patches.lists.yoctoproject.org>

From: hulkoba <jacoba@neighbourhood.ie>

to unify and improve UX
To improve the performance we download the pico.css file instead of fetchin=
g it on load.
---
 patch-status/index.html                             | 5 +++--
 patch-status/resources/pico.fluid.classless.min.css | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 patch-status/resources/pico.fluid.classless.min.css

diff --git a/patch-status/index.html b/patch-status/index.html
index b54beccd..514e916f 100644
--- a/patch-status/index.html
+++ b/patch-status/index.html
@@ -6,6 +6,7 @@ SPDX-License-Identifier: MIT
         <script src=3D"https://d3js.org/d3.v5.min.js"></script>
         <script src=3D"https://cdnjs.cloudflare.com/ajax/libs/c3/0.6.0/c3.=
min.js"></script>
         <link href=3D"https://cdnjs.cloudflare.com/ajax/libs/c3/0.6.0/c3.m=
in.css" rel=3D"stylesheet">
+        <link rel=3D"stylesheet" href=3D"pico.fluid.classless.min.css">
         <style>
             .c3-line {
                 stroke-width: 2px;
@@ -13,6 +14,7 @@ SPDX-License-Identifier: MIT
         </style>
     </head>
     <body>
+      <main>
         <h1>Current CVE status for OE-Core/Poky</h1>
         <ul>
         <li><a href=3D"cve-status-master.txt">master</a></li>
@@ -21,7 +23,6 @@ SPDX-License-Identifier: MIT
         <li><a href=3D"cve-status-dunfell.txt">dunfell</a></li>
         </ul>
=20
-        <p><a href=3D"index-full.html">Multi year data</a></p>
=20
         <h2>CVE Trends for OE-Core/Poky</h2>
         <div id=3D"cve_chart"></div>
@@ -57,7 +58,7 @@ SPDX-License-Identifier: MIT
             <li><a href=3D"../cve-count-byday-lastyear.json">cve-count-byd=
ay-lastyear.json</a></li>
             <li><a href=3D"releases.csv">releases.csv</a></li>
         </ul>
-
+      </main>
         <script type=3D"text/javascript">
             var valid_status =3D ['pending', 'backport', 'inappropriate', =
'accepted', 'submitted', 'denied'];
             var label_names =3D {
diff --git a/patch-status/resources/pico.fluid.classless.min.css b/patch-st=
atus/resources/pico.fluid.classless.min.css
new file mode 100644
index 00000000..143be8af
--- /dev/null
+++ b/patch-status/resources/pico.fluid.classless.min.css
@@ -0,0 +1,4 @@
+@charset "UTF-8";/*!
+ * Pico CSS =E2=9C=A8 v2.0.6 (https://picocss.com)
+ * Copyright 2019-2024 - Licensed under MIT
+ */:root{--pico-font-family-emoji:"Apple Color Emoji","Segoe UI Emoji","Se=
goe UI Symbol","Noto Color Emoji";--pico-font-family-sans-serif:system-ui,"=
Segoe UI",Roboto,Oxygen,Ubuntu,Cantarell,Helvetica,Arial,"Helvetica Neue",s=
ans-serif,var(--pico-font-family-emoji);--pico-font-family-monospace:ui-mon=
ospace,SFMono-Regular,"SF Mono",Menlo,Consolas,"Liberation Mono",monospace,=
var(--pico-font-family-emoji);--pico-font-family:var(--pico-font-family-san=
s-serif);--pico-line-height:1.5;--pico-font-weight:400;--pico-font-size:100=
%;--pico-text-underline-offset:0.1rem;--pico-border-radius:0.25rem;--pico-b=
order-width:0.0625rem;--pico-outline-width:0.125rem;--pico-transition:0.2s =
ease-in-out;--pico-spacing:1rem;--pico-typography-spacing-vertical:1rem;--p=
ico-block-spacing-vertical:var(--pico-spacing);--pico-block-spacing-horizon=
tal:var(--pico-spacing);--pico-form-element-spacing-vertical:0.75rem;--pico=
-form-element-spacing-horizontal:1rem;--pico-group-box-shadow:0 0 0 rgba(0,=
 0, 0, 0);--pico-group-box-shadow-focus-with-button:0 0 0 var(--pico-outlin=
e-width) var(--pico-primary-focus);--pico-group-box-shadow-focus-with-input=
:0 0 0 0.0625rem var(--pico-form-element-border-color);--pico-modal-overlay=
-backdrop-filter:blur(0.375rem);--pico-nav-element-spacing-vertical:1rem;--=
pico-nav-element-spacing-horizontal:0.5rem;--pico-nav-link-spacing-vertical=
:0.5rem;--pico-nav-link-spacing-horizontal:0.5rem;--pico-nav-breadcrumb-div=
ider:">";--pico-icon-checkbox:url("data:image/svg+xml,%3Csvg xmlns=3D'http:=
//www.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fil=
l=3D'none' stroke=3D'rgb(255, 255, 255)' stroke-width=3D'4' stroke-linecap=
=3D'round' stroke-linejoin=3D'round'%3E%3Cpolyline points=3D'20 6 9 17 4 12=
'%3E%3C/polyline%3E%3C/svg%3E");--pico-icon-minus:url("data:image/svg+xml,%=
3Csvg xmlns=3D'http://www.w3.org/2000/svg' width=3D'24' height=3D'24' viewB=
ox=3D'0 0 24 24' fill=3D'none' stroke=3D'rgb(255, 255, 255)' stroke-width=
=3D'4' stroke-linecap=3D'round' stroke-linejoin=3D'round'%3E%3Cline x1=3D'5=
' y1=3D'12' x2=3D'19' y2=3D'12'%3E%3C/line%3E%3C/svg%3E");--pico-icon-chevr=
on:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w3.org/2000/svg' widt=
h=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'none' stroke=3D'rgb(13=
6, 145, 164)' stroke-width=3D'2' stroke-linecap=3D'round' stroke-linejoin=
=3D'round'%3E%3Cpolyline points=3D'6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg=
%3E");--pico-icon-date:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w=
3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'no=
ne' stroke=3D'rgb(136, 145, 164)' stroke-width=3D'2' stroke-linecap=3D'roun=
d' stroke-linejoin=3D'round'%3E%3Crect x=3D'3' y=3D'4' width=3D'18' height=
=3D'18' rx=3D'2' ry=3D'2'%3E%3C/rect%3E%3Cline x1=3D'16' y1=3D'2' x2=3D'16'=
 y2=3D'6'%3E%3C/line%3E%3Cline x1=3D'8' y1=3D'2' x2=3D'8' y2=3D'6'%3E%3C/li=
ne%3E%3Cline x1=3D'3' y1=3D'10' x2=3D'21' y2=3D'10'%3E%3C/line%3E%3C/svg%3E=
");--pico-icon-time:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w3.o=
rg/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'none'=
 stroke=3D'rgb(136, 145, 164)' stroke-width=3D'2' stroke-linecap=3D'round' =
stroke-linejoin=3D'round'%3E%3Ccircle cx=3D'12' cy=3D'12' r=3D'10'%3E%3C/ci=
rcle%3E%3Cpolyline points=3D'12 6 12 12 16 14'%3E%3C/polyline%3E%3C/svg%3E"=
);--pico-icon-search:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w3.=
org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'none=
' stroke=3D'rgb(136, 145, 164)' stroke-width=3D'1.5' stroke-linecap=3D'roun=
d' stroke-linejoin=3D'round'%3E%3Ccircle cx=3D'11' cy=3D'11' r=3D'8'%3E%3C/=
circle%3E%3Cline x1=3D'21' y1=3D'21' x2=3D'16.65' y2=3D'16.65'%3E%3C/line%3=
E%3C/svg%3E");--pico-icon-close:url("data:image/svg+xml,%3Csvg xmlns=3D'htt=
p://www.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' f=
ill=3D'none' stroke=3D'rgb(136, 145, 164)' stroke-width=3D'3' stroke-lineca=
p=3D'round' stroke-linejoin=3D'round'%3E%3Cline x1=3D'18' y1=3D'6' x2=3D'6'=
 y2=3D'18'%3E%3C/line%3E%3Cline x1=3D'6' y1=3D'6' x2=3D'18' y2=3D'18'%3E%3C=
/line%3E%3C/svg%3E");--pico-icon-loading:url("data:image/svg+xml,%3Csvg fil=
l=3D'none' height=3D'24' width=3D'24' viewBox=3D'0 0 24 24' xmlns=3D'http:/=
/www.w3.org/2000/svg' %3E%3Cstyle%3E g %7B animation: rotate 2s linear infi=
nite; transform-origin: center center; %7D circle %7B stroke-dasharray: 75,=
100; stroke-dashoffset: -5; animation: dash 1.5s ease-in-out infinite; stro=
ke-linecap: round; %7D @keyframes rotate %7B 0%25 %7B transform: rotate(0de=
g); %7D 100%25 %7B transform: rotate(360deg); %7D %7D @keyframes dash %7B 0=
%25 %7B stroke-dasharray: 1,100; stroke-dashoffset: 0; %7D 50%25 %7B stroke=
-dasharray: 44.5,100; stroke-dashoffset: -17.5; %7D 100%25 %7B stroke-dasha=
rray: 44.5,100; stroke-dashoffset: -62; %7D %7D %3C/style%3E%3Cg%3E%3Ccircl=
e cx=3D'12' cy=3D'12' r=3D'10' fill=3D'none' stroke=3D'rgb(136, 145, 164)' =
stroke-width=3D'4' /%3E%3C/g%3E%3C/svg%3E")}@media (min-width:576px){:root{=
--pico-font-size:106.25%}}@media (min-width:768px){:root{--pico-font-size:1=
12.5%}}@media (min-width:1024px){:root{--pico-font-size:118.75%}}@media (mi=
n-width:1280px){:root{--pico-font-size:125%}}@media (min-width:1536px){:roo=
t{--pico-font-size:131.25%}}a{--pico-text-decoration:underline}small{--pico=
-font-size:0.875em}h1,h2,h3,h4,h5,h6{--pico-font-weight:700}h1{--pico-font-=
size:2rem;--pico-line-height:1.125;--pico-typography-spacing-top:3rem}h2{--=
pico-font-size:1.75rem;--pico-line-height:1.15;--pico-typography-spacing-to=
p:2.625rem}h3{--pico-font-size:1.5rem;--pico-line-height:1.175;--pico-typog=
raphy-spacing-top:2.25rem}h4{--pico-font-size:1.25rem;--pico-line-height:1.=
2;--pico-typography-spacing-top:1.874rem}h5{--pico-font-size:1.125rem;--pic=
o-line-height:1.225;--pico-typography-spacing-top:1.6875rem}h6{--pico-font-=
size:1rem;--pico-line-height:1.25;--pico-typography-spacing-top:1.5rem}tfoo=
t td,tfoot th,thead td,thead th{--pico-font-weight:600;--pico-border-width:=
0.1875rem}code,kbd,pre,samp{--pico-font-family:var(--pico-font-family-monos=
pace)}kbd{--pico-font-weight:bolder}:where(select,textarea),input:not([type=
=3Dsubmit],[type=3Dbutton],[type=3Dreset],[type=3Dcheckbox],[type=3Dradio],=
[type=3Dfile]){--pico-outline-width:0.0625rem}[type=3Dsearch]{--pico-border=
-radius:5rem}[type=3Dcheckbox],[type=3Dradio]{--pico-border-width:0.125rem}=
[type=3Dcheckbox][role=3Dswitch]{--pico-border-width:0.1875rem}[role=3Dsear=
ch]{--pico-border-radius:5rem}[role=3Dgroup] [role=3Dbutton],[role=3Dgroup]=
 [type=3Dbutton],[role=3Dgroup] [type=3Dsubmit],[role=3Dgroup] button,[role=
=3Dsearch] [role=3Dbutton],[role=3Dsearch] [type=3Dbutton],[role=3Dsearch] =
[type=3Dsubmit],[role=3Dsearch] button{--pico-form-element-spacing-horizont=
al:2rem}details summary[role=3Dbutton]::after{filter:brightness(0) invert(1=
)}[aria-busy=3Dtrue]:not(input,select,textarea):is(button,[type=3Dsubmit],[=
type=3Dbutton],[type=3Dreset],[role=3Dbutton])::before{filter:brightness(0)=
 invert(1)}:root:not([data-theme=3Ddark]),[data-theme=3Dlight]{--pico-backg=
round-color:#fff;--pico-color:#373c44;--pico-text-selection-color:rgba(2, 1=
54, 232, 0.25);--pico-muted-color:#646b79;--pico-muted-border-color:#e7eaf0=
;--pico-primary:#0172ad;--pico-primary-background:#0172ad;--pico-primary-bo=
rder:var(--pico-primary-background);--pico-primary-underline:rgba(1, 114, 1=
73, 0.5);--pico-primary-hover:#015887;--pico-primary-hover-background:#0265=
9a;--pico-primary-hover-border:var(--pico-primary-hover-background);--pico-=
primary-hover-underline:var(--pico-primary-hover);--pico-primary-focus:rgba=
(2, 154, 232, 0.5);--pico-primary-inverse:#fff;--pico-secondary:#5d6b89;--p=
ico-secondary-background:#525f7a;--pico-secondary-border:var(--pico-seconda=
ry-background);--pico-secondary-underline:rgba(93, 107, 137, 0.5);--pico-se=
condary-hover:#48536b;--pico-secondary-hover-background:#48536b;--pico-seco=
ndary-hover-border:var(--pico-secondary-hover-background);--pico-secondary-=
hover-underline:var(--pico-secondary-hover);--pico-secondary-focus:rgba(93,=
 107, 137, 0.25);--pico-secondary-inverse:#fff;--pico-contrast:#181c25;--pi=
co-contrast-background:#181c25;--pico-contrast-border:var(--pico-contrast-b=
ackground);--pico-contrast-underline:rgba(24, 28, 37, 0.5);--pico-contrast-=
hover:#000;--pico-contrast-hover-background:#000;--pico-contrast-hover-bord=
er:var(--pico-contrast-hover-background);--pico-contrast-hover-underline:va=
r(--pico-secondary-hover);--pico-contrast-focus:rgba(93, 107, 137, 0.25);--=
pico-contrast-inverse:#fff;--pico-box-shadow:0.0145rem 0.029rem 0.174rem rg=
ba(129, 145, 181, 0.01698),0.0335rem 0.067rem 0.402rem rgba(129, 145, 181, =
0.024),0.0625rem 0.125rem 0.75rem rgba(129, 145, 181, 0.03),0.1125rem 0.225=
rem 1.35rem rgba(129, 145, 181, 0.036),0.2085rem 0.417rem 2.502rem rgba(129=
, 145, 181, 0.04302),0.5rem 1rem 6rem rgba(129, 145, 181, 0.06),0 0 0 0.062=
5rem rgba(129, 145, 181, 0.015);--pico-h1-color:#2d3138;--pico-h2-color:#37=
3c44;--pico-h3-color:#424751;--pico-h4-color:#4d535e;--pico-h5-color:#5c637=
0;--pico-h6-color:#646b79;--pico-mark-background-color:#fde7c0;--pico-mark-=
color:#0f1114;--pico-ins-color:#1d6a54;--pico-del-color:#883935;--pico-bloc=
kquote-border-color:var(--pico-muted-border-color);--pico-blockquote-footer=
-color:var(--pico-muted-color);--pico-button-box-shadow:0 0 0 rgba(0, 0, 0,=
 0);--pico-button-hover-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-table-bord=
er-color:var(--pico-muted-border-color);--pico-table-row-stripped-backgroun=
d-color:rgba(111, 120, 135, 0.0375);--pico-code-background-color:#f3f5f7;--=
pico-code-color:#646b79;--pico-code-kbd-background-color:var(--pico-color);=
--pico-code-kbd-color:var(--pico-background-color);--pico-form-element-back=
ground-color:#fbfcfc;--pico-form-element-selected-background-color:#dfe3eb;=
--pico-form-element-border-color:#cfd5e2;--pico-form-element-color:#23262c;=
--pico-form-element-placeholder-color:var(--pico-muted-color);--pico-form-e=
lement-active-background-color:#fff;--pico-form-element-active-border-color=
:var(--pico-primary-border);--pico-form-element-focus-color:var(--pico-prim=
ary-border);--pico-form-element-disabled-opacity:0.5;--pico-form-element-in=
valid-border-color:#b86a6b;--pico-form-element-invalid-active-border-color:=
#c84f48;--pico-form-element-invalid-focus-color:var(--pico-form-element-inv=
alid-active-border-color);--pico-form-element-valid-border-color:#4c9b8a;--=
pico-form-element-valid-active-border-color:#279977;--pico-form-element-val=
id-focus-color:var(--pico-form-element-valid-active-border-color);--pico-sw=
itch-background-color:#bfc7d9;--pico-switch-checked-background-color:var(--=
pico-primary-background);--pico-switch-color:#fff;--pico-switch-thumb-box-s=
hadow:0 0 0 rgba(0, 0, 0, 0);--pico-range-border-color:#dfe3eb;--pico-range=
-active-border-color:#bfc7d9;--pico-range-thumb-border-color:var(--pico-bac=
kground-color);--pico-range-thumb-color:var(--pico-secondary-background);--=
pico-range-thumb-active-color:var(--pico-primary-background);--pico-accordi=
on-border-color:var(--pico-muted-border-color);--pico-accordion-active-summ=
ary-color:var(--pico-primary-hover);--pico-accordion-close-summary-color:va=
r(--pico-color);--pico-accordion-open-summary-color:var(--pico-muted-color)=
;--pico-card-background-color:var(--pico-background-color);--pico-card-bord=
er-color:var(--pico-muted-border-color);--pico-card-box-shadow:var(--pico-b=
ox-shadow);--pico-card-sectioning-background-color:#fbfcfc;--pico-loading-s=
pinner-opacity:0.5;--pico-modal-overlay-background-color:rgba(232, 234, 237=
, 0.75);--pico-progress-background-color:#dfe3eb;--pico-progress-color:var(=
--pico-primary-background);--pico-tooltip-background-color:var(--pico-contr=
ast-background);--pico-tooltip-color:var(--pico-contrast-inverse);--pico-ic=
on-valid:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w3.org/2000/svg=
' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'none' stroke=3D'=
rgb(76, 155, 138)' stroke-width=3D'2' stroke-linecap=3D'round' stroke-linej=
oin=3D'round'%3E%3Cpolyline points=3D'20 6 9 17 4 12'%3E%3C/polyline%3E%3C/=
svg%3E");--pico-icon-invalid:url("data:image/svg+xml,%3Csvg xmlns=3D'http:/=
/www.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=
=3D'none' stroke=3D'rgb(200, 79, 72)' stroke-width=3D'2' stroke-linecap=3D'=
round' stroke-linejoin=3D'round'%3E%3Ccircle cx=3D'12' cy=3D'12' r=3D'10'%3=
E%3C/circle%3E%3Cline x1=3D'12' y1=3D'8' x2=3D'12' y2=3D'12'%3E%3C/line%3E%=
3Cline x1=3D'12' y1=3D'16' x2=3D'12.01' y2=3D'16'%3E%3C/line%3E%3C/svg%3E")=
;color-scheme:light}:root:not([data-theme=3Ddark]) input:is([type=3Dsubmit]=
,[type=3Dbutton],[type=3Dreset],[type=3Dcheckbox],[type=3Dradio],[type=3Dfi=
le]),[data-theme=3Dlight] input:is([type=3Dsubmit],[type=3Dbutton],[type=3D=
reset],[type=3Dcheckbox],[type=3Dradio],[type=3Dfile]){--pico-form-element-=
focus-color:var(--pico-primary-focus)}@media only screen and (prefers-color=
-scheme:dark){:root:not([data-theme]){--pico-background-color:#13171f;--pic=
o-color:#c2c7d0;--pico-text-selection-color:rgba(1, 170, 255, 0.1875);--pic=
o-muted-color:#7b8495;--pico-muted-border-color:#202632;--pico-primary:#01a=
aff;--pico-primary-background:#0172ad;--pico-primary-border:var(--pico-prim=
ary-background);--pico-primary-underline:rgba(1, 170, 255, 0.5);--pico-prim=
ary-hover:#79c0ff;--pico-primary-hover-background:#017fc0;--pico-primary-ho=
ver-border:var(--pico-primary-hover-background);--pico-primary-hover-underl=
ine:var(--pico-primary-hover);--pico-primary-focus:rgba(1, 170, 255, 0.375)=
;--pico-primary-inverse:#fff;--pico-secondary:#969eaf;--pico-secondary-back=
ground:#525f7a;--pico-secondary-border:var(--pico-secondary-background);--p=
ico-secondary-underline:rgba(150, 158, 175, 0.5);--pico-secondary-hover:#b3=
b9c5;--pico-secondary-hover-background:#5d6b89;--pico-secondary-hover-borde=
r:var(--pico-secondary-hover-background);--pico-secondary-hover-underline:v=
ar(--pico-secondary-hover);--pico-secondary-focus:rgba(144, 158, 190, 0.25)=
;--pico-secondary-inverse:#fff;--pico-contrast:#dfe3eb;--pico-contrast-back=
ground:#eff1f4;--pico-contrast-border:var(--pico-contrast-background);--pic=
o-contrast-underline:rgba(223, 227, 235, 0.5);--pico-contrast-hover:#fff;--=
pico-contrast-hover-background:#fff;--pico-contrast-hover-border:var(--pico=
-contrast-hover-background);--pico-contrast-hover-underline:var(--pico-cont=
rast-hover);--pico-contrast-focus:rgba(207, 213, 226, 0.25);--pico-contrast=
-inverse:#000;--pico-box-shadow:0.0145rem 0.029rem 0.174rem rgba(7, 9, 12, =
0.01698),0.0335rem 0.067rem 0.402rem rgba(7, 9, 12, 0.024),0.0625rem 0.125r=
em 0.75rem rgba(7, 9, 12, 0.03),0.1125rem 0.225rem 1.35rem rgba(7, 9, 12, 0=
.036),0.2085rem 0.417rem 2.502rem rgba(7, 9, 12, 0.04302),0.5rem 1rem 6rem =
rgba(7, 9, 12, 0.06),0 0 0 0.0625rem rgba(7, 9, 12, 0.015);--pico-h1-color:=
#f0f1f3;--pico-h2-color:#e0e3e7;--pico-h3-color:#c2c7d0;--pico-h4-color:#b3=
b9c5;--pico-h5-color:#a4acba;--pico-h6-color:#8891a4;--pico-mark-background=
-color:#014063;--pico-mark-color:#fff;--pico-ins-color:#62af9a;--pico-del-c=
olor:#ce7e7b;--pico-blockquote-border-color:var(--pico-muted-border-color);=
--pico-blockquote-footer-color:var(--pico-muted-color);--pico-button-box-sh=
adow:0 0 0 rgba(0, 0, 0, 0);--pico-button-hover-box-shadow:0 0 0 rgba(0, 0,=
 0, 0);--pico-table-border-color:var(--pico-muted-border-color);--pico-tabl=
e-row-stripped-background-color:rgba(111, 120, 135, 0.0375);--pico-code-bac=
kground-color:#1a1f28;--pico-code-color:#8891a4;--pico-code-kbd-background-=
color:var(--pico-color);--pico-code-kbd-color:var(--pico-background-color);=
--pico-form-element-background-color:#1c212c;--pico-form-element-selected-b=
ackground-color:#2a3140;--pico-form-element-border-color:#2a3140;--pico-for=
m-element-color:#e0e3e7;--pico-form-element-placeholder-color:#8891a4;--pic=
o-form-element-active-background-color:#1a1f28;--pico-form-element-active-b=
order-color:var(--pico-primary-border);--pico-form-element-focus-color:var(=
--pico-primary-border);--pico-form-element-disabled-opacity:0.5;--pico-form=
-element-invalid-border-color:#964a50;--pico-form-element-invalid-active-bo=
rder-color:#b7403b;--pico-form-element-invalid-focus-color:var(--pico-form-=
element-invalid-active-border-color);--pico-form-element-valid-border-color=
:#2a7b6f;--pico-form-element-valid-active-border-color:#16896a;--pico-form-=
element-valid-focus-color:var(--pico-form-element-valid-active-border-color=
);--pico-switch-background-color:#333c4e;--pico-switch-checked-background-c=
olor:var(--pico-primary-background);--pico-switch-color:#fff;--pico-switch-=
thumb-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-range-border-color:#202632;-=
-pico-range-active-border-color:#2a3140;--pico-range-thumb-border-color:var=
(--pico-background-color);--pico-range-thumb-color:var(--pico-secondary-bac=
kground);--pico-range-thumb-active-color:var(--pico-primary-background);--p=
ico-accordion-border-color:var(--pico-muted-border-color);--pico-accordion-=
active-summary-color:var(--pico-primary-hover);--pico-accordion-close-summa=
ry-color:var(--pico-color);--pico-accordion-open-summary-color:var(--pico-m=
uted-color);--pico-card-background-color:#181c25;--pico-card-border-color:v=
ar(--pico-card-background-color);--pico-card-box-shadow:var(--pico-box-shad=
ow);--pico-card-sectioning-background-color:#1a1f28;--pico-loading-spinner-=
opacity:0.5;--pico-modal-overlay-background-color:rgba(8, 9, 10, 0.75);--pi=
co-progress-background-color:#202632;--pico-progress-color:var(--pico-prima=
ry-background);--pico-tooltip-background-color:var(--pico-contrast-backgrou=
nd);--pico-tooltip-color:var(--pico-contrast-inverse);--pico-icon-valid:url=
("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w3.org/2000/svg' width=3D'2=
4' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'none' stroke=3D'rgb(42, 123,=
 111)' stroke-width=3D'2' stroke-linecap=3D'round' stroke-linejoin=3D'round=
'%3E%3Cpolyline points=3D'20 6 9 17 4 12'%3E%3C/polyline%3E%3C/svg%3E");--p=
ico-icon-invalid:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w3.org/=
2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'none' st=
roke=3D'rgb(150, 74, 80)' stroke-width=3D'2' stroke-linecap=3D'round' strok=
e-linejoin=3D'round'%3E%3Ccircle cx=3D'12' cy=3D'12' r=3D'10'%3E%3C/circle%=
3E%3Cline x1=3D'12' y1=3D'8' x2=3D'12' y2=3D'12'%3E%3C/line%3E%3Cline x1=3D=
'12' y1=3D'16' x2=3D'12.01' y2=3D'16'%3E%3C/line%3E%3C/svg%3E");color-schem=
e:dark}:root:not([data-theme]) input:is([type=3Dsubmit],[type=3Dbutton],[ty=
pe=3Dreset],[type=3Dcheckbox],[type=3Dradio],[type=3Dfile]){--pico-form-ele=
ment-focus-color:var(--pico-primary-focus)}}[data-theme=3Ddark]{--pico-back=
ground-color:#13171f;--pico-color:#c2c7d0;--pico-text-selection-color:rgba(=
1, 170, 255, 0.1875);--pico-muted-color:#7b8495;--pico-muted-border-color:#=
202632;--pico-primary:#01aaff;--pico-primary-background:#0172ad;--pico-prim=
ary-border:var(--pico-primary-background);--pico-primary-underline:rgba(1, =
170, 255, 0.5);--pico-primary-hover:#79c0ff;--pico-primary-hover-background=
:#017fc0;--pico-primary-hover-border:var(--pico-primary-hover-background);-=
-pico-primary-hover-underline:var(--pico-primary-hover);--pico-primary-focu=
s:rgba(1, 170, 255, 0.375);--pico-primary-inverse:#fff;--pico-secondary:#96=
9eaf;--pico-secondary-background:#525f7a;--pico-secondary-border:var(--pico=
-secondary-background);--pico-secondary-underline:rgba(150, 158, 175, 0.5);=
--pico-secondary-hover:#b3b9c5;--pico-secondary-hover-background:#5d6b89;--=
pico-secondary-hover-border:var(--pico-secondary-hover-background);--pico-s=
econdary-hover-underline:var(--pico-secondary-hover);--pico-secondary-focus=
:rgba(144, 158, 190, 0.25);--pico-secondary-inverse:#fff;--pico-contrast:#d=
fe3eb;--pico-contrast-background:#eff1f4;--pico-contrast-border:var(--pico-=
contrast-background);--pico-contrast-underline:rgba(223, 227, 235, 0.5);--p=
ico-contrast-hover:#fff;--pico-contrast-hover-background:#fff;--pico-contra=
st-hover-border:var(--pico-contrast-hover-background);--pico-contrast-hover=
-underline:var(--pico-contrast-hover);--pico-contrast-focus:rgba(207, 213, =
226, 0.25);--pico-contrast-inverse:#000;--pico-box-shadow:0.0145rem 0.029re=
m 0.174rem rgba(7, 9, 12, 0.01698),0.0335rem 0.067rem 0.402rem rgba(7, 9, 1=
2, 0.024),0.0625rem 0.125rem 0.75rem rgba(7, 9, 12, 0.03),0.1125rem 0.225re=
m 1.35rem rgba(7, 9, 12, 0.036),0.2085rem 0.417rem 2.502rem rgba(7, 9, 12, =
0.04302),0.5rem 1rem 6rem rgba(7, 9, 12, 0.06),0 0 0 0.0625rem rgba(7, 9, 1=
2, 0.015);--pico-h1-color:#f0f1f3;--pico-h2-color:#e0e3e7;--pico-h3-color:#=
c2c7d0;--pico-h4-color:#b3b9c5;--pico-h5-color:#a4acba;--pico-h6-color:#889=
1a4;--pico-mark-background-color:#014063;--pico-mark-color:#fff;--pico-ins-=
color:#62af9a;--pico-del-color:#ce7e7b;--pico-blockquote-border-color:var(-=
-pico-muted-border-color);--pico-blockquote-footer-color:var(--pico-muted-c=
olor);--pico-button-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-button-hover-b=
ox-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-table-border-color:var(--pico-muted=
-border-color);--pico-table-row-stripped-background-color:rgba(111, 120, 13=
5, 0.0375);--pico-code-background-color:#1a1f28;--pico-code-color:#8891a4;-=
-pico-code-kbd-background-color:var(--pico-color);--pico-code-kbd-color:var=
(--pico-background-color);--pico-form-element-background-color:#1c212c;--pi=
co-form-element-selected-background-color:#2a3140;--pico-form-element-borde=
r-color:#2a3140;--pico-form-element-color:#e0e3e7;--pico-form-element-place=
holder-color:#8891a4;--pico-form-element-active-background-color:#1a1f28;--=
pico-form-element-active-border-color:var(--pico-primary-border);--pico-for=
m-element-focus-color:var(--pico-primary-border);--pico-form-element-disabl=
ed-opacity:0.5;--pico-form-element-invalid-border-color:#964a50;--pico-form=
-element-invalid-active-border-color:#b7403b;--pico-form-element-invalid-fo=
cus-color:var(--pico-form-element-invalid-active-border-color);--pico-form-=
element-valid-border-color:#2a7b6f;--pico-form-element-valid-active-border-=
color:#16896a;--pico-form-element-valid-focus-color:var(--pico-form-element=
-valid-active-border-color);--pico-switch-background-color:#333c4e;--pico-s=
witch-checked-background-color:var(--pico-primary-background);--pico-switch=
-color:#fff;--pico-switch-thumb-box-shadow:0 0 0 rgba(0, 0, 0, 0);--pico-ra=
nge-border-color:#202632;--pico-range-active-border-color:#2a3140;--pico-ra=
nge-thumb-border-color:var(--pico-background-color);--pico-range-thumb-colo=
r:var(--pico-secondary-background);--pico-range-thumb-active-color:var(--pi=
co-primary-background);--pico-accordion-border-color:var(--pico-muted-borde=
r-color);--pico-accordion-active-summary-color:var(--pico-primary-hover);--=
pico-accordion-close-summary-color:var(--pico-color);--pico-accordion-open-=
summary-color:var(--pico-muted-color);--pico-card-background-color:#181c25;=
--pico-card-border-color:var(--pico-card-background-color);--pico-card-box-=
shadow:var(--pico-box-shadow);--pico-card-sectioning-background-color:#1a1f=
28;--pico-loading-spinner-opacity:0.5;--pico-modal-overlay-background-color=
:rgba(8, 9, 10, 0.75);--pico-progress-background-color:#202632;--pico-progr=
ess-color:var(--pico-primary-background);--pico-tooltip-background-color:va=
r(--pico-contrast-background);--pico-tooltip-color:var(--pico-contrast-inve=
rse);--pico-icon-valid:url("data:image/svg+xml,%3Csvg xmlns=3D'http://www.w=
3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0 0 24 24' fill=3D'no=
ne' stroke=3D'rgb(42, 123, 111)' stroke-width=3D'2' stroke-linecap=3D'round=
' stroke-linejoin=3D'round'%3E%3Cpolyline points=3D'20 6 9 17 4 12'%3E%3C/p=
olyline%3E%3C/svg%3E");--pico-icon-invalid:url("data:image/svg+xml,%3Csvg x=
mlns=3D'http://www.w3.org/2000/svg' width=3D'24' height=3D'24' viewBox=3D'0=
 0 24 24' fill=3D'none' stroke=3D'rgb(150, 74, 80)' stroke-width=3D'2' stro=
ke-linecap=3D'round' stroke-linejoin=3D'round'%3E%3Ccircle cx=3D'12' cy=3D'=
12' r=3D'10'%3E%3C/circle%3E%3Cline x1=3D'12' y1=3D'8' x2=3D'12' y2=3D'12'%=
3E%3C/line%3E%3Cline x1=3D'12' y1=3D'16' x2=3D'12.01' y2=3D'16'%3E%3C/line%=
3E%3C/svg%3E");color-scheme:dark}[data-theme=3Ddark] input:is([type=3Dsubmi=
t],[type=3Dbutton],[type=3Dreset],[type=3Dcheckbox],[type=3Dradio],[type=3D=
file]){--pico-form-element-focus-color:var(--pico-primary-focus)}[type=3Dch=
eckbox],[type=3Dradio],[type=3Drange],progress{accent-color:var(--pico-prim=
ary)}*,::after,::before{box-sizing:border-box;background-repeat:no-repeat}:=
:after,::before{text-decoration:inherit;vertical-align:inherit}:where(:root=
){-webkit-tap-highlight-color:transparent;-webkit-text-size-adjust:100%;-mo=
z-text-size-adjust:100%;text-size-adjust:100%;background-color:var(--pico-b=
ackground-color);color:var(--pico-color);font-weight:var(--pico-font-weight=
);font-size:var(--pico-font-size);line-height:var(--pico-line-height);font-=
family:var(--pico-font-family);text-underline-offset:var(--pico-text-underl=
ine-offset);text-rendering:optimizeLegibility;overflow-wrap:break-word;-moz=
-tab-size:4;-o-tab-size:4;tab-size:4}body{width:100%;margin:0}main{display:=
block}body>footer,body>header,body>main{width:100%;margin-right:auto;margin=
-left:auto;padding:var(--pico-block-spacing-vertical) var(--pico-block-spac=
ing-horizontal)}section{margin-bottom:var(--pico-block-spacing-vertical)}b,=
strong{font-weight:bolder}sub,sup{position:relative;font-size:.75em;line-he=
ight:0;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}address,bloc=
kquote,dl,ol,p,pre,table,ul{margin-top:0;margin-bottom:var(--pico-typograph=
y-spacing-vertical);color:var(--pico-color);font-style:normal;font-weight:v=
ar(--pico-font-weight)}h1,h2,h3,h4,h5,h6{margin-top:0;margin-bottom:var(--p=
ico-typography-spacing-vertical);color:var(--pico-color);font-weight:var(--=
pico-font-weight);font-size:var(--pico-font-size);line-height:var(--pico-li=
ne-height);font-family:var(--pico-font-family)}h1{--pico-color:var(--pico-h=
1-color)}h2{--pico-color:var(--pico-h2-color)}h3{--pico-color:var(--pico-h3=
-color)}h4{--pico-color:var(--pico-h4-color)}h5{--pico-color:var(--pico-h5-=
color)}h6{--pico-color:var(--pico-h6-color)}:where(article,address,blockquo=
te,dl,figure,form,ol,p,pre,table,ul)~:is(h1,h2,h3,h4,h5,h6){margin-top:var(=
--pico-typography-spacing-top)}p{margin-bottom:var(--pico-typography-spacin=
g-vertical)}hgroup{margin-bottom:var(--pico-typography-spacing-vertical)}hg=
roup>*{margin-top:0;margin-bottom:0}hgroup>:not(:first-child):last-child{--=
pico-color:var(--pico-muted-color);--pico-font-weight:unset;font-size:1rem}=
:where(ol,ul) li{margin-bottom:calc(var(--pico-typography-spacing-vertical)=
 * .25)}:where(dl,ol,ul) :where(dl,ol,ul){margin:0;margin-top:calc(var(--pi=
co-typography-spacing-vertical) * .25)}ul li{list-style:square}mark{padding=
:.125rem .25rem;background-color:var(--pico-mark-background-color);color:va=
r(--pico-mark-color);vertical-align:baseline}blockquote{display:block;margi=
n:var(--pico-typography-spacing-vertical) 0;padding:var(--pico-spacing);bor=
der-right:none;border-left:.25rem solid var(--pico-blockquote-border-color)=
;border-inline-start:0.25rem solid var(--pico-blockquote-border-color);bord=
er-inline-end:none}blockquote footer{margin-top:calc(var(--pico-typography-=
spacing-vertical) * .5);color:var(--pico-blockquote-footer-color)}abbr[titl=
e]{border-bottom:1px dotted;text-decoration:none;cursor:help}ins{color:var(=
--pico-ins-color);text-decoration:none}del{color:var(--pico-del-color)}::-m=
oz-selection{background-color:var(--pico-text-selection-color)}::selection{=
background-color:var(--pico-text-selection-color)}:where(a:not([role=3Dbutt=
on])),[role=3Dlink]{--pico-color:var(--pico-primary);--pico-background-colo=
r:transparent;--pico-underline:var(--pico-primary-underline);outline:0;back=
ground-color:var(--pico-background-color);color:var(--pico-color);-webkit-t=
ext-decoration:var(--pico-text-decoration);text-decoration:var(--pico-text-=
decoration);text-decoration-color:var(--pico-underline);text-underline-offs=
et:0.125em;transition:background-color var(--pico-transition),color var(--p=
ico-transition),box-shadow var(--pico-transition),-webkit-text-decoration v=
ar(--pico-transition);transition:background-color var(--pico-transition),co=
lor var(--pico-transition),text-decoration var(--pico-transition),box-shado=
w var(--pico-transition);transition:background-color var(--pico-transition)=
,color var(--pico-transition),text-decoration var(--pico-transition),box-sh=
adow var(--pico-transition),-webkit-text-decoration var(--pico-transition)}=
:where(a:not([role=3Dbutton])):is([aria-current]:not([aria-current=3Dfalse]=
),:hover,:active,:focus),[role=3Dlink]:is([aria-current]:not([aria-current=
=3Dfalse]),:hover,:active,:focus){--pico-color:var(--pico-primary-hover);--=
pico-underline:var(--pico-primary-hover-underline);--pico-text-decoration:u=
nderline}:where(a:not([role=3Dbutton])):focus-visible,[role=3Dlink]:focus-v=
isible{box-shadow:0 0 0 var(--pico-outline-width) var(--pico-primary-focus)=
}a[role=3Dbutton]{display:inline-block}button{margin:0;overflow:visible;fon=
t-family:inherit;text-transform:none}[type=3Dbutton],[type=3Dreset],[type=
=3Dsubmit],button{-webkit-appearance:button}[role=3Dbutton],[type=3Dbutton]=
,[type=3Dfile]::file-selector-button,[type=3Dreset],[type=3Dsubmit],button{=
--pico-background-color:var(--pico-primary-background);--pico-border-color:=
var(--pico-primary-border);--pico-color:var(--pico-primary-inverse);--pico-=
box-shadow:var(--pico-button-box-shadow, 0 0 0 rgba(0, 0, 0, 0));padding:va=
r(--pico-form-element-spacing-vertical) var(--pico-form-element-spacing-hor=
izontal);border:var(--pico-border-width) solid var(--pico-border-color);bor=
der-radius:var(--pico-border-radius);outline:0;background-color:var(--pico-=
background-color);box-shadow:var(--pico-box-shadow);color:var(--pico-color)=
;font-weight:var(--pico-font-weight);font-size:1rem;line-height:var(--pico-=
line-height);text-align:center;text-decoration:none;cursor:pointer;-webkit-=
user-select:none;-moz-user-select:none;user-select:none;transition:backgrou=
nd-color var(--pico-transition),border-color var(--pico-transition),color v=
ar(--pico-transition),box-shadow var(--pico-transition)}[role=3Dbutton]:is(=
:hover,:active,:focus),[role=3Dbutton]:is([aria-current]:not([aria-current=
=3Dfalse])),[type=3Dbutton]:is(:hover,:active,:focus),[type=3Dbutton]:is([a=
ria-current]:not([aria-current=3Dfalse])),[type=3Dfile]::file-selector-butt=
on:is(:hover,:active,:focus),[type=3Dfile]::file-selector-button:is([aria-c=
urrent]:not([aria-current=3Dfalse])),[type=3Dreset]:is(:hover,:active,:focu=
s),[type=3Dreset]:is([aria-current]:not([aria-current=3Dfalse])),[type=3Dsu=
bmit]:is(:hover,:active,:focus),[type=3Dsubmit]:is([aria-current]:not([aria=
-current=3Dfalse])),button:is(:hover,:active,:focus),button:is([aria-curren=
t]:not([aria-current=3Dfalse])){--pico-background-color:var(--pico-primary-=
hover-background);--pico-border-color:var(--pico-primary-hover-border);--pi=
co-box-shadow:var(--pico-button-hover-box-shadow, 0 0 0 rgba(0, 0, 0, 0));-=
-pico-color:var(--pico-primary-inverse)}[role=3Dbutton]:focus,[role=3Dbutto=
n]:is([aria-current]:not([aria-current=3Dfalse])):focus,[type=3Dbutton]:foc=
us,[type=3Dbutton]:is([aria-current]:not([aria-current=3Dfalse])):focus,[ty=
pe=3Dfile]::file-selector-button:focus,[type=3Dfile]::file-selector-button:=
is([aria-current]:not([aria-current=3Dfalse])):focus,[type=3Dreset]:focus,[=
type=3Dreset]:is([aria-current]:not([aria-current=3Dfalse])):focus,[type=3D=
submit]:focus,[type=3Dsubmit]:is([aria-current]:not([aria-current=3Dfalse])=
):focus,button:focus,button:is([aria-current]:not([aria-current=3Dfalse])):=
focus{--pico-box-shadow:var(--pico-button-hover-box-shadow, 0 0 0 rgba(0, 0=
, 0, 0)),0 0 0 var(--pico-outline-width) var(--pico-primary-focus)}[type=3D=
button],[type=3Dreset],[type=3Dsubmit]{margin-bottom:var(--pico-spacing)}[t=
ype=3Dfile]::file-selector-button,[type=3Dreset]{--pico-background-color:va=
r(--pico-secondary-background);--pico-border-color:var(--pico-secondary-bor=
der);--pico-color:var(--pico-secondary-inverse);cursor:pointer}[type=3Dfile=
]::file-selector-button:is([aria-current]:not([aria-current=3Dfalse]),:hove=
r,:active,:focus),[type=3Dreset]:is([aria-current]:not([aria-current=3Dfals=
e]),:hover,:active,:focus){--pico-background-color:var(--pico-secondary-hov=
er-background);--pico-border-color:var(--pico-secondary-hover-border);--pic=
o-color:var(--pico-secondary-inverse)}[type=3Dfile]::file-selector-button:f=
ocus,[type=3Dreset]:focus{--pico-box-shadow:var(--pico-button-hover-box-sha=
dow, 0 0 0 rgba(0, 0, 0, 0)),0 0 0 var(--pico-outline-width) var(--pico-sec=
ondary-focus)}:where(button,[type=3Dsubmit],[type=3Dreset],[type=3Dbutton],=
[role=3Dbutton])[disabled],:where(fieldset[disabled]) :is(button,[type=3Dsu=
bmit],[type=3Dbutton],[type=3Dreset],[role=3Dbutton]){opacity:.5;pointer-ev=
ents:none}:where(table){width:100%;border-collapse:collapse;border-spacing:=
0;text-indent:0}td,th{padding:calc(var(--pico-spacing)/ 2) var(--pico-spaci=
ng);border-bottom:var(--pico-border-width) solid var(--pico-table-border-co=
lor);background-color:var(--pico-background-color);color:var(--pico-color);=
font-weight:var(--pico-font-weight);text-align:left;text-align:start}tfoot =
td,tfoot th{border-top:var(--pico-border-width) solid var(--pico-table-bord=
er-color);border-bottom:0}table.striped tbody tr:nth-child(odd) td,table.st=
riped tbody tr:nth-child(odd) th{background-color:var(--pico-table-row-stri=
pped-background-color)}:where(audio,canvas,iframe,img,svg,video){vertical-a=
lign:middle}audio,video{display:inline-block}audio:not([controls]){display:=
none;height:0}:where(iframe){border-style:none}img{max-width:100%;height:au=
to;border-style:none}:where(svg:not([fill])){fill:currentColor}svg:not(:roo=
t){overflow:hidden}code,kbd,pre,samp{font-size:.875em;font-family:var(--pic=
o-font-family)}pre code{font-size:inherit;font-family:inherit}pre{-ms-overf=
low-style:scrollbar;overflow:auto}code,kbd,pre{border-radius:var(--pico-bor=
der-radius);background:var(--pico-code-background-color);color:var(--pico-c=
ode-color);font-weight:var(--pico-font-weight);line-height:initial}code,kbd=
{display:inline-block;padding:.375rem}pre{display:block;margin-bottom:var(-=
-pico-spacing);overflow-x:auto}pre>code{display:block;padding:var(--pico-sp=
acing);background:0 0;line-height:var(--pico-line-height)}kbd{background-co=
lor:var(--pico-code-kbd-background-color);color:var(--pico-code-kbd-color);=
vertical-align:baseline}figure{display:block;margin:0;padding:0}figure figc=
aption{padding:calc(var(--pico-spacing) * .5) 0;color:var(--pico-muted-colo=
r)}hr{height:0;margin:var(--pico-typography-spacing-vertical) 0;border:0;bo=
rder-top:1px solid var(--pico-muted-border-color);color:inherit}[hidden],te=
mplate{display:none!important}canvas{display:inline-block}input,optgroup,se=
lect,textarea{margin:0;font-size:1rem;line-height:var(--pico-line-height);f=
ont-family:inherit;letter-spacing:inherit}input{overflow:visible}select{tex=
t-transform:none}legend{max-width:100%;padding:0;color:inherit;white-space:=
normal}textarea{overflow:auto}[type=3Dcheckbox],[type=3Dradio]{padding:0}::=
-webkit-inner-spin-button,::-webkit-outer-spin-button{height:auto}[type=3Ds=
earch]{-webkit-appearance:textfield;outline-offset:-2px}[type=3Dsearch]::-w=
ebkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-butto=
n{-webkit-appearance:button;font:inherit}::-moz-focus-inner{padding:0;borde=
r-style:none}:-moz-focusring{outline:0}:-moz-ui-invalid{box-shadow:none}::-=
ms-expand{display:none}[type=3Dfile],[type=3Drange]{padding:0;border-width:=
0}input:not([type=3Dcheckbox],[type=3Dradio],[type=3Drange]){height:calc(1r=
em * var(--pico-line-height) + var(--pico-form-element-spacing-vertical) * =
2 + var(--pico-border-width) * 2)}fieldset{width:100%;margin:0;margin-botto=
m:var(--pico-spacing);padding:0;border:0}fieldset legend,label{display:bloc=
k;margin-bottom:calc(var(--pico-spacing) * .375);color:var(--pico-color);fo=
nt-weight:var(--pico-form-label-font-weight,var(--pico-font-weight))}fields=
et legend{margin-bottom:calc(var(--pico-spacing) * .5)}button[type=3Dsubmit=
],input:not([type=3Dcheckbox],[type=3Dradio]),select,textarea{width:100%}in=
put:not([type=3Dcheckbox],[type=3Dradio],[type=3Drange],[type=3Dfile]),sele=
ct,textarea{-webkit-appearance:none;-moz-appearance:none;appearance:none;pa=
dding:var(--pico-form-element-spacing-vertical) var(--pico-form-element-spa=
cing-horizontal)}input,select,textarea{--pico-background-color:var(--pico-f=
orm-element-background-color);--pico-border-color:var(--pico-form-element-b=
order-color);--pico-color:var(--pico-form-element-color);--pico-box-shadow:=
none;border:var(--pico-border-width) solid var(--pico-border-color);border-=
radius:var(--pico-border-radius);outline:0;background-color:var(--pico-back=
ground-color);box-shadow:var(--pico-box-shadow);color:var(--pico-color);fon=
t-weight:var(--pico-font-weight);transition:background-color var(--pico-tra=
nsition),border-color var(--pico-transition),color var(--pico-transition),b=
ox-shadow var(--pico-transition)}:where(select,textarea):not([readonly]):is=
(:active,:focus),input:not([type=3Dsubmit],[type=3Dbutton],[type=3Dreset],[=
type=3Dcheckbox],[type=3Dradio],[readonly]):is(:active,:focus){--pico-backg=
round-color:var(--pico-form-element-active-background-color)}:where(select,=
textarea):not([readonly]):is(:active,:focus),input:not([type=3Dsubmit],[typ=
e=3Dbutton],[type=3Dreset],[role=3Dswitch],[readonly]):is(:active,:focus){-=
-pico-border-color:var(--pico-form-element-active-border-color)}:where(sele=
ct,textarea):not([readonly]):focus,input:not([type=3Dsubmit],[type=3Dbutton=
],[type=3Dreset],[type=3Drange],[type=3Dfile],[readonly]):focus{--pico-box-=
shadow:0 0 0 var(--pico-outline-width) var(--pico-form-element-focus-color)=
}:where(fieldset[disabled]) :is(input:not([type=3Dsubmit],[type=3Dbutton],[=
type=3Dreset]),select,textarea),input:not([type=3Dsubmit],[type=3Dbutton],[=
type=3Dreset])[disabled],label[aria-disabled=3Dtrue],select[disabled],texta=
rea[disabled]{opacity:var(--pico-form-element-disabled-opacity);pointer-eve=
nts:none}label[aria-disabled=3Dtrue] input[disabled]{opacity:1}:where(input=
,select,textarea):not([type=3Dcheckbox],[type=3Dradio],[type=3Ddate],[type=
=3Ddatetime-local],[type=3Dmonth],[type=3Dtime],[type=3Dweek],[type=3Drange=
])[aria-invalid]{padding-right:calc(var(--pico-form-element-spacing-horizon=
tal) + 1.5rem)!important;padding-left:var(--pico-form-element-spacing-horiz=
ontal);padding-inline-start:var(--pico-form-element-spacing-horizontal)!imp=
ortant;padding-inline-end:calc(var(--pico-form-element-spacing-horizontal) =
+ 1.5rem)!important;background-position:center right .75rem;background-size=
:1rem auto;background-repeat:no-repeat}:where(input,select,textarea):not([t=
ype=3Dcheckbox],[type=3Dradio],[type=3Ddate],[type=3Ddatetime-local],[type=
=3Dmonth],[type=3Dtime],[type=3Dweek],[type=3Drange])[aria-invalid=3Dfalse]=
:not(select){background-image:var(--pico-icon-valid)}:where(input,select,te=
xtarea):not([type=3Dcheckbox],[type=3Dradio],[type=3Ddate],[type=3Ddatetime=
-local],[type=3Dmonth],[type=3Dtime],[type=3Dweek],[type=3Drange])[aria-inv=
alid=3Dtrue]:not(select){background-image:var(--pico-icon-invalid)}:where(i=
nput,select,textarea)[aria-invalid=3Dfalse]{--pico-border-color:var(--pico-=
form-element-valid-border-color)}:where(input,select,textarea)[aria-invalid=
=3Dfalse]:is(:active,:focus){--pico-border-color:var(--pico-form-element-va=
lid-active-border-color)!important}:where(input,select,textarea)[aria-inval=
id=3Dfalse]:is(:active,:focus):not([type=3Dcheckbox],[type=3Dradio]){--pico=
-box-shadow:0 0 0 var(--pico-outline-width) var(--pico-form-element-valid-f=
ocus-color)!important}:where(input,select,textarea)[aria-invalid=3Dtrue]{--=
pico-border-color:var(--pico-form-element-invalid-border-color)}:where(inpu=
t,select,textarea)[aria-invalid=3Dtrue]:is(:active,:focus){--pico-border-co=
lor:var(--pico-form-element-invalid-active-border-color)!important}:where(i=
nput,select,textarea)[aria-invalid=3Dtrue]:is(:active,:focus):not([type=3Dc=
heckbox],[type=3Dradio]){--pico-box-shadow:0 0 0 var(--pico-outline-width) =
var(--pico-form-element-invalid-focus-color)!important}[dir=3Drtl] :where(i=
nput,select,textarea):not([type=3Dcheckbox],[type=3Dradio]):is([aria-invali=
d],[aria-invalid=3Dtrue],[aria-invalid=3Dfalse]){background-position:center=
 left .75rem}input::-webkit-input-placeholder,input::placeholder,select:inv=
alid,textarea::-webkit-input-placeholder,textarea::placeholder{color:var(--=
pico-form-element-placeholder-color);opacity:1}input:not([type=3Dcheckbox],=
[type=3Dradio]),select,textarea{margin-bottom:var(--pico-spacing)}select::-=
ms-expand{border:0;background-color:transparent}select:not([multiple],[size=
]){padding-right:calc(var(--pico-form-element-spacing-horizontal) + 1.5rem)=
;padding-left:var(--pico-form-element-spacing-horizontal);padding-inline-st=
art:var(--pico-form-element-spacing-horizontal);padding-inline-end:calc(var=
(--pico-form-element-spacing-horizontal) + 1.5rem);background-image:var(--p=
ico-icon-chevron);background-position:center right .75rem;background-size:1=
rem auto;background-repeat:no-repeat}select[multiple] option:checked{backgr=
ound:var(--pico-form-element-selected-background-color);color:var(--pico-fo=
rm-element-color)}[dir=3Drtl] select:not([multiple],[size]){background-posi=
tion:center left .75rem}textarea{display:block;resize:vertical}textarea[ari=
a-invalid]{--pico-icon-height:calc(1rem * var(--pico-line-height) + var(--p=
ico-form-element-spacing-vertical) * 2 + var(--pico-border-width) * 2);back=
ground-position:top right .75rem!important;background-size:1rem var(--pico-=
icon-height)!important}:where(input,select,textarea,fieldset)+small{display=
:block;width:100%;margin-top:calc(var(--pico-spacing) * -.75);margin-bottom=
:var(--pico-spacing);color:var(--pico-muted-color)}:where(input,select,text=
area,fieldset)[aria-invalid=3Dfalse]+small{color:var(--pico-ins-color)}:whe=
re(input,select,textarea,fieldset)[aria-invalid=3Dtrue]+small{color:var(--p=
ico-del-color)}label>:where(input,select,textarea){margin-top:calc(var(--pi=
co-spacing) * .25)}label:has([type=3Dcheckbox],[type=3Dradio]){width:-moz-f=
it-content;width:fit-content;cursor:pointer}[type=3Dcheckbox],[type=3Dradio=
]{-webkit-appearance:none;-moz-appearance:none;appearance:none;width:1.25em=
;height:1.25em;margin-top:-.125em;margin-inline-end:.5em;border-width:var(-=
-pico-border-width);vertical-align:middle;cursor:pointer}[type=3Dcheckbox]:=
:-ms-check,[type=3Dradio]::-ms-check{display:none}[type=3Dcheckbox]:checked=
,[type=3Dcheckbox]:checked:active,[type=3Dcheckbox]:checked:focus,[type=3Dr=
adio]:checked,[type=3Dradio]:checked:active,[type=3Dradio]:checked:focus{--=
pico-background-color:var(--pico-primary-background);--pico-border-color:va=
r(--pico-primary-border);background-image:var(--pico-icon-checkbox);backgro=
und-position:center;background-size:.75em auto;background-repeat:no-repeat}=
[type=3Dcheckbox]~label,[type=3Dradio]~label{display:inline-block;margin-bo=
ttom:0;cursor:pointer}[type=3Dcheckbox]~label:not(:last-of-type),[type=3Dra=
dio]~label:not(:last-of-type){margin-inline-end:1em}[type=3Dcheckbox]:indet=
erminate{--pico-background-color:var(--pico-primary-background);--pico-bord=
er-color:var(--pico-primary-border);background-image:var(--pico-icon-minus)=
;background-position:center;background-size:.75em auto;background-repeat:no=
-repeat}[type=3Dradio]{border-radius:50%}[type=3Dradio]:checked,[type=3Drad=
io]:checked:active,[type=3Dradio]:checked:focus{--pico-background-color:var=
(--pico-primary-inverse);border-width:.35em;background-image:none}[type=3Dc=
heckbox][role=3Dswitch]{--pico-background-color:var(--pico-switch-backgroun=
d-color);--pico-color:var(--pico-switch-color);width:2.25em;height:1.25em;b=
order:var(--pico-border-width) solid var(--pico-border-color);border-radius=
:1.25em;background-color:var(--pico-background-color);line-height:1.25em}[t=
ype=3Dcheckbox][role=3Dswitch]:not([aria-invalid]){--pico-border-color:var(=
--pico-switch-background-color)}[type=3Dcheckbox][role=3Dswitch]:before{dis=
play:block;aspect-ratio:1;height:100%;border-radius:50%;background-color:va=
r(--pico-color);box-shadow:var(--pico-switch-thumb-box-shadow);content:"";t=
ransition:margin .1s ease-in-out}[type=3Dcheckbox][role=3Dswitch]:focus{--p=
ico-background-color:var(--pico-switch-background-color);--pico-border-colo=
r:var(--pico-switch-background-color)}[type=3Dcheckbox][role=3Dswitch]:chec=
ked{--pico-background-color:var(--pico-switch-checked-background-color);--p=
ico-border-color:var(--pico-switch-checked-background-color);background-ima=
ge:none}[type=3Dcheckbox][role=3Dswitch]:checked::before{margin-inline-star=
t:calc(2.25em - 1.25em)}[type=3Dcheckbox][role=3Dswitch][disabled]{--pico-b=
ackground-color:var(--pico-border-color)}[type=3Dcheckbox][aria-invalid=3Df=
alse]:checked,[type=3Dcheckbox][aria-invalid=3Dfalse]:checked:active,[type=
=3Dcheckbox][aria-invalid=3Dfalse]:checked:focus,[type=3Dcheckbox][role=3Ds=
witch][aria-invalid=3Dfalse]:checked,[type=3Dcheckbox][role=3Dswitch][aria-=
invalid=3Dfalse]:checked:active,[type=3Dcheckbox][role=3Dswitch][aria-inval=
id=3Dfalse]:checked:focus{--pico-background-color:var(--pico-form-element-v=
alid-border-color)}[type=3Dcheckbox]:checked:active[aria-invalid=3Dtrue],[t=
ype=3Dcheckbox]:checked:focus[aria-invalid=3Dtrue],[type=3Dcheckbox]:checke=
d[aria-invalid=3Dtrue],[type=3Dcheckbox][role=3Dswitch]:checked:active[aria=
-invalid=3Dtrue],[type=3Dcheckbox][role=3Dswitch]:checked:focus[aria-invali=
d=3Dtrue],[type=3Dcheckbox][role=3Dswitch]:checked[aria-invalid=3Dtrue]{--p=
ico-background-color:var(--pico-form-element-invalid-border-color)}[type=3D=
checkbox][aria-invalid=3Dfalse]:checked,[type=3Dcheckbox][aria-invalid=3Dfa=
lse]:checked:active,[type=3Dcheckbox][aria-invalid=3Dfalse]:checked:focus,[=
type=3Dcheckbox][role=3Dswitch][aria-invalid=3Dfalse]:checked,[type=3Dcheck=
box][role=3Dswitch][aria-invalid=3Dfalse]:checked:active,[type=3Dcheckbox][=
role=3Dswitch][aria-invalid=3Dfalse]:checked:focus,[type=3Dradio][aria-inva=
lid=3Dfalse]:checked,[type=3Dradio][aria-invalid=3Dfalse]:checked:active,[t=
ype=3Dradio][aria-invalid=3Dfalse]:checked:focus{--pico-border-color:var(--=
pico-form-element-valid-border-color)}[type=3Dcheckbox]:checked:active[aria=
-invalid=3Dtrue],[type=3Dcheckbox]:checked:focus[aria-invalid=3Dtrue],[type=
=3Dcheckbox]:checked[aria-invalid=3Dtrue],[type=3Dcheckbox][role=3Dswitch]:=
checked:active[aria-invalid=3Dtrue],[type=3Dcheckbox][role=3Dswitch]:checke=
d:focus[aria-invalid=3Dtrue],[type=3Dcheckbox][role=3Dswitch]:checked[aria-=
invalid=3Dtrue],[type=3Dradio]:checked:active[aria-invalid=3Dtrue],[type=3D=
radio]:checked:focus[aria-invalid=3Dtrue],[type=3Dradio]:checked[aria-inval=
id=3Dtrue]{--pico-border-color:var(--pico-form-element-invalid-border-color=
)}[type=3Dcolor]::-webkit-color-swatch-wrapper{padding:0}[type=3Dcolor]::-m=
oz-focus-inner{padding:0}[type=3Dcolor]::-webkit-color-swatch{border:0;bord=
er-radius:calc(var(--pico-border-radius) * .5)}[type=3Dcolor]::-moz-color-s=
watch{border:0;border-radius:calc(var(--pico-border-radius) * .5)}input:not=
([type=3Dcheckbox],[type=3Dradio],[type=3Drange],[type=3Dfile]):is([type=3D=
date],[type=3Ddatetime-local],[type=3Dmonth],[type=3Dtime],[type=3Dweek]){-=
-pico-icon-position:0.75rem;--pico-icon-width:1rem;padding-right:calc(var(-=
-pico-icon-width) + var(--pico-icon-position));background-image:var(--pico-=
icon-date);background-position:center right var(--pico-icon-position);backg=
round-size:var(--pico-icon-width) auto;background-repeat:no-repeat}input:no=
t([type=3Dcheckbox],[type=3Dradio],[type=3Drange],[type=3Dfile])[type=3Dtim=
e]{background-image:var(--pico-icon-time)}[type=3Ddate]::-webkit-calendar-p=
icker-indicator,[type=3Ddatetime-local]::-webkit-calendar-picker-indicator,=
[type=3Dmonth]::-webkit-calendar-picker-indicator,[type=3Dtime]::-webkit-ca=
lendar-picker-indicator,[type=3Dweek]::-webkit-calendar-picker-indicator{wi=
dth:var(--pico-icon-width);margin-right:calc(var(--pico-icon-width) * -1);m=
argin-left:var(--pico-icon-position);opacity:0}@-moz-document url-prefix(){=
[type=3Ddate],[type=3Ddatetime-local],[type=3Dmonth],[type=3Dtime],[type=3D=
week]{padding-right:var(--pico-form-element-spacing-horizontal)!important;b=
ackground-image:none!important}}[dir=3Drtl] :is([type=3Ddate],[type=3Ddatet=
ime-local],[type=3Dmonth],[type=3Dtime],[type=3Dweek]){text-align:right}[ty=
pe=3Dfile]{--pico-color:var(--pico-muted-color);margin-left:calc(var(--pico=
-outline-width) * -1);padding:calc(var(--pico-form-element-spacing-vertical=
) * .5) 0;padding-left:var(--pico-outline-width);border:0;border-radius:0;b=
ackground:0 0}[type=3Dfile]::file-selector-button{margin-right:calc(var(--p=
ico-spacing)/ 2);padding:calc(var(--pico-form-element-spacing-vertical) * .=
5) var(--pico-form-element-spacing-horizontal)}[type=3Dfile]:is(:hover,:act=
ive,:focus)::file-selector-button{--pico-background-color:var(--pico-second=
ary-hover-background);--pico-border-color:var(--pico-secondary-hover-border=
)}[type=3Dfile]:focus::file-selector-button{--pico-box-shadow:var(--pico-bu=
tton-hover-box-shadow, 0 0 0 rgba(0, 0, 0, 0)),0 0 0 var(--pico-outline-wid=
th) var(--pico-secondary-focus)}[type=3Drange]{-webkit-appearance:none;-moz=
-appearance:none;appearance:none;width:100%;height:1.25rem;background:0 0}[=
type=3Drange]::-webkit-slider-runnable-track{width:100%;height:.375rem;bord=
er-radius:var(--pico-border-radius);background-color:var(--pico-range-borde=
r-color);-webkit-transition:background-color var(--pico-transition),box-sha=
dow var(--pico-transition);transition:background-color var(--pico-transitio=
n),box-shadow var(--pico-transition)}[type=3Drange]::-moz-range-track{width=
:100%;height:.375rem;border-radius:var(--pico-border-radius);background-col=
or:var(--pico-range-border-color);-moz-transition:background-color var(--pi=
co-transition),box-shadow var(--pico-transition);transition:background-colo=
r var(--pico-transition),box-shadow var(--pico-transition)}[type=3Drange]::=
-ms-track{width:100%;height:.375rem;border-radius:var(--pico-border-radius)=
;background-color:var(--pico-range-border-color);-ms-transition:background-=
color var(--pico-transition),box-shadow var(--pico-transition);transition:b=
ackground-color var(--pico-transition),box-shadow var(--pico-transition)}[t=
ype=3Drange]::-webkit-slider-thumb{-webkit-appearance:none;width:1.25rem;he=
ight:1.25rem;margin-top:-.4375rem;border:2px solid var(--pico-range-thumb-b=
order-color);border-radius:50%;background-color:var(--pico-range-thumb-colo=
r);cursor:pointer;-webkit-transition:background-color var(--pico-transition=
),transform var(--pico-transition);transition:background-color var(--pico-t=
ransition),transform var(--pico-transition)}[type=3Drange]::-moz-range-thum=
b{-webkit-appearance:none;width:1.25rem;height:1.25rem;margin-top:-.4375rem=
;border:2px solid var(--pico-range-thumb-border-color);border-radius:50%;ba=
ckground-color:var(--pico-range-thumb-color);cursor:pointer;-moz-transition=
:background-color var(--pico-transition),transform var(--pico-transition);t=
ransition:background-color var(--pico-transition),transform var(--pico-tran=
sition)}[type=3Drange]::-ms-thumb{-webkit-appearance:none;width:1.25rem;hei=
ght:1.25rem;margin-top:-.4375rem;border:2px solid var(--pico-range-thumb-bo=
rder-color);border-radius:50%;background-color:var(--pico-range-thumb-color=
);cursor:pointer;-ms-transition:background-color var(--pico-transition),tra=
nsform var(--pico-transition);transition:background-color var(--pico-transi=
tion),transform var(--pico-transition)}[type=3Drange]:active,[type=3Drange]=
:focus-within{--pico-range-border-color:var(--pico-range-active-border-colo=
r);--pico-range-thumb-color:var(--pico-range-thumb-active-color)}[type=3Dra=
nge]:active::-webkit-slider-thumb{transform:scale(1.25)}[type=3Drange]:acti=
ve::-moz-range-thumb{transform:scale(1.25)}[type=3Drange]:active::-ms-thumb=
{transform:scale(1.25)}input:not([type=3Dcheckbox],[type=3Dradio],[type=3Dr=
ange],[type=3Dfile])[type=3Dsearch]{padding-inline-start:calc(var(--pico-fo=
rm-element-spacing-horizontal) + 1.75rem);background-image:var(--pico-icon-=
search);background-position:center left calc(var(--pico-form-element-spacin=
g-horizontal) + .125rem);background-size:1rem auto;background-repeat:no-rep=
eat}input:not([type=3Dcheckbox],[type=3Dradio],[type=3Drange],[type=3Dfile]=
)[type=3Dsearch][aria-invalid]{padding-inline-start:calc(var(--pico-form-el=
ement-spacing-horizontal) + 1.75rem)!important;background-position:center l=
eft 1.125rem,center right .75rem}input:not([type=3Dcheckbox],[type=3Dradio]=
,[type=3Drange],[type=3Dfile])[type=3Dsearch][aria-invalid=3Dfalse]{backgro=
und-image:var(--pico-icon-search),var(--pico-icon-valid)}input:not([type=3D=
checkbox],[type=3Dradio],[type=3Drange],[type=3Dfile])[type=3Dsearch][aria-=
invalid=3Dtrue]{background-image:var(--pico-icon-search),var(--pico-icon-in=
valid)}[dir=3Drtl] :where(input):not([type=3Dcheckbox],[type=3Dradio],[type=
=3Drange],[type=3Dfile])[type=3Dsearch]{background-position:center right 1.=
125rem}[dir=3Drtl] :where(input):not([type=3Dcheckbox],[type=3Dradio],[type=
=3Drange],[type=3Dfile])[type=3Dsearch][aria-invalid]{background-position:c=
enter right 1.125rem,center left .75rem}details{display:block;margin-bottom=
:var(--pico-spacing)}details summary{line-height:1rem;list-style-type:none;=
cursor:pointer;transition:color var(--pico-transition)}details summary:not(=
[role]){color:var(--pico-accordion-close-summary-color)}details summary::-w=
ebkit-details-marker{display:none}details summary::marker{display:none}deta=
ils summary::-moz-list-bullet{list-style-type:none}details summary::after{d=
isplay:block;width:1rem;height:1rem;margin-inline-start:calc(var(--pico-spa=
cing,1rem) * .5);float:right;transform:rotate(-90deg);background-image:var(=
--pico-icon-chevron);background-position:right center;background-size:1rem =
auto;background-repeat:no-repeat;content:"";transition:transform var(--pico=
-transition)}details summary:focus{outline:0}details summary:focus:not([rol=
e]){color:var(--pico-accordion-active-summary-color)}details summary:focus-=
visible:not([role]){outline:var(--pico-outline-width) solid var(--pico-prim=
ary-focus);outline-offset:calc(var(--pico-spacing,1rem) * 0.5);color:var(--=
pico-primary)}details summary[role=3Dbutton]{width:100%;text-align:left}det=
ails summary[role=3Dbutton]::after{height:calc(1rem * var(--pico-line-heigh=
t,1.5))}details[open]>summary{margin-bottom:var(--pico-spacing)}details[ope=
n]>summary:not([role]):not(:focus){color:var(--pico-accordion-open-summary-=
color)}details[open]>summary::after{transform:rotate(0)}[dir=3Drtl] details=
 summary{text-align:right}[dir=3Drtl] details summary::after{float:left;bac=
kground-position:left center}article{margin-bottom:var(--pico-block-spacing=
-vertical);padding:var(--pico-block-spacing-vertical) var(--pico-block-spac=
ing-horizontal);border-radius:var(--pico-border-radius);background:var(--pi=
co-card-background-color);box-shadow:var(--pico-card-box-shadow)}article>fo=
oter,article>header{margin-right:calc(var(--pico-block-spacing-horizontal) =
* -1);margin-left:calc(var(--pico-block-spacing-horizontal) * -1);padding:c=
alc(var(--pico-block-spacing-vertical) * .66) var(--pico-block-spacing-hori=
zontal);background-color:var(--pico-card-sectioning-background-color)}artic=
le>header{margin-top:calc(var(--pico-block-spacing-vertical) * -1);margin-b=
ottom:var(--pico-block-spacing-vertical);border-bottom:var(--pico-border-wi=
dth) solid var(--pico-card-border-color);border-top-right-radius:var(--pico=
-border-radius);border-top-left-radius:var(--pico-border-radius)}article>fo=
oter{margin-top:var(--pico-block-spacing-vertical);margin-bottom:calc(var(-=
-pico-block-spacing-vertical) * -1);border-top:var(--pico-border-width) sol=
id var(--pico-card-border-color);border-bottom-right-radius:var(--pico-bord=
er-radius);border-bottom-left-radius:var(--pico-border-radius)}[role=3Dgrou=
p],[role=3Dsearch]{display:inline-flex;position:relative;width:100%;margin-=
bottom:var(--pico-spacing);border-radius:var(--pico-border-radius);box-shad=
ow:var(--pico-group-box-shadow,0 0 0 transparent);vertical-align:middle;tra=
nsition:box-shadow var(--pico-transition)}[role=3Dgroup] input:not([type=3D=
checkbox],[type=3Dradio]),[role=3Dgroup] select,[role=3Dgroup]>*,[role=3Dse=
arch] input:not([type=3Dcheckbox],[type=3Dradio]),[role=3Dsearch] select,[r=
ole=3Dsearch]>*{position:relative;flex:1 1 auto;margin-bottom:0}[role=3Dgro=
up] input:not([type=3Dcheckbox],[type=3Dradio]):not(:first-child),[role=3Dg=
roup] select:not(:first-child),[role=3Dgroup]>:not(:first-child),[role=3Dse=
arch] input:not([type=3Dcheckbox],[type=3Dradio]):not(:first-child),[role=
=3Dsearch] select:not(:first-child),[role=3Dsearch]>:not(:first-child){marg=
in-left:0;border-top-left-radius:0;border-bottom-left-radius:0}[role=3Dgrou=
p] input:not([type=3Dcheckbox],[type=3Dradio]):not(:last-child),[role=3Dgro=
up] select:not(:last-child),[role=3Dgroup]>:not(:last-child),[role=3Dsearch=
] input:not([type=3Dcheckbox],[type=3Dradio]):not(:last-child),[role=3Dsear=
ch] select:not(:last-child),[role=3Dsearch]>:not(:last-child){border-top-ri=
ght-radius:0;border-bottom-right-radius:0}[role=3Dgroup] input:not([type=3D=
checkbox],[type=3Dradio]):focus,[role=3Dgroup] select:focus,[role=3Dgroup]>=
:focus,[role=3Dsearch] input:not([type=3Dcheckbox],[type=3Dradio]):focus,[r=
ole=3Dsearch] select:focus,[role=3Dsearch]>:focus{z-index:2}[role=3Dgroup] =
[role=3Dbutton]:not(:first-child),[role=3Dgroup] [type=3Dbutton]:not(:first=
-child),[role=3Dgroup] [type=3Dreset]:not(:first-child),[role=3Dgroup] [typ=
e=3Dsubmit]:not(:first-child),[role=3Dgroup] button:not(:first-child),[role=
=3Dgroup] input:not([type=3Dcheckbox],[type=3Dradio]):not(:first-child),[ro=
le=3Dgroup] select:not(:first-child),[role=3Dsearch] [role=3Dbutton]:not(:f=
irst-child),[role=3Dsearch] [type=3Dbutton]:not(:first-child),[role=3Dsearc=
h] [type=3Dreset]:not(:first-child),[role=3Dsearch] [type=3Dsubmit]:not(:fi=
rst-child),[role=3Dsearch] button:not(:first-child),[role=3Dsearch] input:n=
ot([type=3Dcheckbox],[type=3Dradio]):not(:first-child),[role=3Dsearch] sele=
ct:not(:first-child){margin-left:calc(var(--pico-border-width) * -1)}[role=
=3Dgroup] [role=3Dbutton],[role=3Dgroup] [type=3Dbutton],[role=3Dgroup] [ty=
pe=3Dreset],[role=3Dgroup] [type=3Dsubmit],[role=3Dgroup] button,[role=3Dse=
arch] [role=3Dbutton],[role=3Dsearch] [type=3Dbutton],[role=3Dsearch] [type=
=3Dreset],[role=3Dsearch] [type=3Dsubmit],[role=3Dsearch] button{width:auto=
}@supports selector(:has(*)){[role=3Dgroup]:has(button:focus,[type=3Dsubmit=
]:focus,[type=3Dbutton]:focus,[role=3Dbutton]:focus),[role=3Dsearch]:has(bu=
tton:focus,[type=3Dsubmit]:focus,[type=3Dbutton]:focus,[role=3Dbutton]:focu=
s){--pico-group-box-shadow:var(--pico-group-box-shadow-focus-with-button)}[=
role=3Dgroup]:has(button:focus,[type=3Dsubmit]:focus,[type=3Dbutton]:focus,=
[role=3Dbutton]:focus) input:not([type=3Dcheckbox],[type=3Dradio]),[role=3D=
group]:has(button:focus,[type=3Dsubmit]:focus,[type=3Dbutton]:focus,[role=
=3Dbutton]:focus) select,[role=3Dsearch]:has(button:focus,[type=3Dsubmit]:f=
ocus,[type=3Dbutton]:focus,[role=3Dbutton]:focus) input:not([type=3Dcheckbo=
x],[type=3Dradio]),[role=3Dsearch]:has(button:focus,[type=3Dsubmit]:focus,[=
type=3Dbutton]:focus,[role=3Dbutton]:focus) select{border-color:transparent=
}[role=3Dgroup]:has(input:not([type=3Dsubmit],[type=3Dbutton]):focus,select=
:focus),[role=3Dsearch]:has(input:not([type=3Dsubmit],[type=3Dbutton]):focu=
s,select:focus){--pico-group-box-shadow:var(--pico-group-box-shadow-focus-w=
ith-input)}[role=3Dgroup]:has(input:not([type=3Dsubmit],[type=3Dbutton]):fo=
cus,select:focus) [role=3Dbutton],[role=3Dgroup]:has(input:not([type=3Dsubm=
it],[type=3Dbutton]):focus,select:focus) [type=3Dbutton],[role=3Dgroup]:has=
(input:not([type=3Dsubmit],[type=3Dbutton]):focus,select:focus) [type=3Dsub=
mit],[role=3Dgroup]:has(input:not([type=3Dsubmit],[type=3Dbutton]):focus,se=
lect:focus) button,[role=3Dsearch]:has(input:not([type=3Dsubmit],[type=3Dbu=
tton]):focus,select:focus) [role=3Dbutton],[role=3Dsearch]:has(input:not([t=
ype=3Dsubmit],[type=3Dbutton]):focus,select:focus) [type=3Dbutton],[role=3D=
search]:has(input:not([type=3Dsubmit],[type=3Dbutton]):focus,select:focus) =
[type=3Dsubmit],[role=3Dsearch]:has(input:not([type=3Dsubmit],[type=3Dbutto=
n]):focus,select:focus) button{--pico-button-box-shadow:0 0 0 var(--pico-bo=
rder-width) var(--pico-primary-border);--pico-button-hover-box-shadow:0 0 0=
 var(--pico-border-width) var(--pico-primary-hover-border)}[role=3Dgroup] [=
role=3Dbutton]:focus,[role=3Dgroup] [type=3Dbutton]:focus,[role=3Dgroup] [t=
ype=3Dreset]:focus,[role=3Dgroup] [type=3Dsubmit]:focus,[role=3Dgroup] butt=
on:focus,[role=3Dsearch] [role=3Dbutton]:focus,[role=3Dsearch] [type=3Dbutt=
on]:focus,[role=3Dsearch] [type=3Dreset]:focus,[role=3Dsearch] [type=3Dsubm=
it]:focus,[role=3Dsearch] button:focus{box-shadow:none}}[role=3Dsearch]>:fi=
rst-child{border-top-left-radius:5rem;border-bottom-left-radius:5rem}[role=
=3Dsearch]>:last-child{border-top-right-radius:5rem;border-bottom-right-rad=
ius:5rem}[aria-busy=3Dtrue]:not(input,select,textarea,html){white-space:now=
rap}[aria-busy=3Dtrue]:not(input,select,textarea,html)::before{display:inli=
ne-block;width:1em;height:1em;background-image:var(--pico-icon-loading);bac=
kground-size:1em auto;background-repeat:no-repeat;content:"";vertical-align=
:-.125em}[aria-busy=3Dtrue]:not(input,select,textarea,html):not(:empty)::be=
fore{margin-inline-end:calc(var(--pico-spacing) * .5)}[aria-busy=3Dtrue]:no=
t(input,select,textarea,html):empty{text-align:center}[role=3Dbutton][aria-=
busy=3Dtrue],[type=3Dbutton][aria-busy=3Dtrue],[type=3Dreset][aria-busy=3Dt=
rue],[type=3Dsubmit][aria-busy=3Dtrue],a[aria-busy=3Dtrue],button[aria-busy=
=3Dtrue]{pointer-events:none}:root{--pico-scrollbar-width:0px}dialog{displa=
y:flex;z-index:999;position:fixed;top:0;right:0;bottom:0;left:0;align-items=
:center;justify-content:center;width:inherit;min-width:100%;height:inherit;=
min-height:100%;padding:0;border:0;-webkit-backdrop-filter:var(--pico-modal=
-overlay-backdrop-filter);backdrop-filter:var(--pico-modal-overlay-backdrop=
-filter);background-color:var(--pico-modal-overlay-background-color);color:=
var(--pico-color)}dialog article{width:100%;max-height:calc(100vh - var(--p=
ico-spacing) * 2);margin:var(--pico-spacing);overflow:auto}@media (min-widt=
h:576px){dialog article{max-width:510px}}@media (min-width:768px){dialog ar=
ticle{max-width:700px}}dialog article>header>*{margin-bottom:0}dialog artic=
le>header :is(a,button)[rel=3Dprev]{margin:0;margin-left:var(--pico-spacing=
);padding:0;float:right}dialog article>footer{text-align:right}dialog artic=
le>footer [role=3Dbutton],dialog article>footer button{margin-bottom:0}dial=
og article>footer [role=3Dbutton]:not(:first-of-type),dialog article>footer=
 button:not(:first-of-type){margin-left:calc(var(--pico-spacing) * .5)}dial=
og article :is(a,button)[rel=3Dprev]{display:block;width:1rem;height:1rem;m=
argin-top:calc(var(--pico-spacing) * -1);margin-bottom:var(--pico-spacing);=
margin-left:auto;border:none;background-image:var(--pico-icon-close);backgr=
ound-position:center;background-size:auto 1rem;background-repeat:no-repeat;=
background-color:transparent;opacity:.5;transition:opacity var(--pico-trans=
ition)}dialog article :is(a,button)[rel=3Dprev]:is([aria-current]:not([aria=
-current=3Dfalse]),:hover,:active,:focus){opacity:1}dialog:not([open]),dial=
og[open=3Dfalse]{display:none}:where(nav li)::before{float:left;content:"=
=E2=80=8B"}nav,nav ul{display:flex}nav{justify-content:space-between;overfl=
ow:visible}nav ol,nav ul{align-items:center;margin-bottom:0;padding:0;list-=
style:none}nav ol:first-of-type,nav ul:first-of-type{margin-left:calc(var(-=
-pico-nav-element-spacing-horizontal) * -1)}nav ol:last-of-type,nav ul:last=
-of-type{margin-right:calc(var(--pico-nav-element-spacing-horizontal) * -1)=
}nav li{display:inline-block;margin:0;padding:var(--pico-nav-element-spacin=
g-vertical) var(--pico-nav-element-spacing-horizontal)}nav li :where(a,[rol=
e=3Dlink]){display:inline-block;margin:calc(var(--pico-nav-link-spacing-ver=
tical) * -1) calc(var(--pico-nav-link-spacing-horizontal) * -1);padding:var=
(--pico-nav-link-spacing-vertical) var(--pico-nav-link-spacing-horizontal);=
border-radius:var(--pico-border-radius)}nav li :where(a,[role=3Dlink]):not(=
:hover){text-decoration:none}nav li [role=3Dbutton],nav li [type=3Dbutton],=
nav li button,nav li input:not([type=3Dcheckbox],[type=3Dradio],[type=3Dran=
ge],[type=3Dfile]),nav li select{height:auto;margin-right:inherit;margin-bo=
ttom:0;margin-left:inherit;padding:calc(var(--pico-nav-link-spacing-vertica=
l) - var(--pico-border-width) * 2) var(--pico-nav-link-spacing-horizontal)}=
nav[aria-label=3Dbreadcrumb]{align-items:center;justify-content:start}nav[a=
ria-label=3Dbreadcrumb] ul li:not(:first-child){margin-inline-start:var(--p=
ico-nav-link-spacing-horizontal)}nav[aria-label=3Dbreadcrumb] ul li a{margi=
n:calc(var(--pico-nav-link-spacing-vertical) * -1) 0;margin-inline-start:ca=
lc(var(--pico-nav-link-spacing-horizontal) * -1)}nav[aria-label=3Dbreadcrum=
b] ul li:not(:last-child)::after{display:inline-block;position:absolute;wid=
th:calc(var(--pico-nav-link-spacing-horizontal) * 4);margin:0 calc(var(--pi=
co-nav-link-spacing-horizontal) * -1);content:var(--pico-nav-breadcrumb-div=
ider);color:var(--pico-muted-color);text-align:center;text-decoration:none;=
white-space:nowrap}nav[aria-label=3Dbreadcrumb] a[aria-current]:not([aria-c=
urrent=3Dfalse]){background-color:transparent;color:inherit;text-decoration=
:none;pointer-events:none}aside li,aside nav,aside ol,aside ul{display:bloc=
k}aside li{padding:calc(var(--pico-nav-element-spacing-vertical) * .5) var(=
--pico-nav-element-spacing-horizontal)}aside li a{display:block}aside li [r=
ole=3Dbutton]{margin:inherit}[dir=3Drtl] nav[aria-label=3Dbreadcrumb] ul li=
:not(:last-child) ::after{content:"\\"}progress{display:inline-block;vertic=
al-align:baseline}progress{-webkit-appearance:none;-moz-appearance:none;dis=
play:inline-block;appearance:none;width:100%;height:.5rem;margin-bottom:cal=
c(var(--pico-spacing) * .5);overflow:hidden;border:0;border-radius:var(--pi=
co-border-radius);background-color:var(--pico-progress-background-color);co=
lor:var(--pico-progress-color)}progress::-webkit-progress-bar{border-radius=
:var(--pico-border-radius);background:0 0}progress[value]::-webkit-progress=
-value{background-color:var(--pico-progress-color);-webkit-transition:inlin=
e-size var(--pico-transition);transition:inline-size var(--pico-transition)=
}progress::-moz-progress-bar{background-color:var(--pico-progress-color)}@m=
edia (prefers-reduced-motion:no-preference){progress:indeterminate{backgrou=
nd:var(--pico-progress-background-color) linear-gradient(to right,var(--pic=
o-progress-color) 30%,var(--pico-progress-background-color) 30%) top left/1=
50% 150% no-repeat;animation:progress-indeterminate 1s linear infinite}prog=
ress:indeterminate[value]::-webkit-progress-value{background-color:transpar=
ent}progress:indeterminate::-moz-progress-bar{background-color:transparent}=
}@media (prefers-reduced-motion:no-preference){[dir=3Drtl] progress:indeter=
minate{animation-direction:reverse}}@keyframes progress-indeterminate{0%{ba=
ckground-position:200% 0}100%{background-position:-200% 0}}[data-tooltip]{p=
osition:relative}[data-tooltip]:not(a,button,input){border-bottom:1px dotte=
d;text-decoration:none;cursor:help}[data-tooltip]::after,[data-tooltip]::be=
fore,[data-tooltip][data-placement=3Dtop]::after,[data-tooltip][data-placem=
ent=3Dtop]::before{display:block;z-index:99;position:absolute;bottom:100%;l=
eft:50%;padding:.25rem .5rem;overflow:hidden;transform:translate(-50%,-.25r=
em);border-radius:var(--pico-border-radius);background:var(--pico-tooltip-b=
ackground-color);content:attr(data-tooltip);color:var(--pico-tooltip-color)=
;font-style:normal;font-weight:var(--pico-font-weight);font-size:.875rem;te=
xt-decoration:none;text-overflow:ellipsis;white-space:nowrap;opacity:0;poin=
ter-events:none}[data-tooltip]::after,[data-tooltip][data-placement=3Dtop]:=
:after{padding:0;transform:translate(-50%,0);border-top:.3rem solid;border-=
right:.3rem solid transparent;border-left:.3rem solid transparent;border-ra=
dius:0;background-color:transparent;content:"";color:var(--pico-tooltip-bac=
kground-color)}[data-tooltip][data-placement=3Dbottom]::after,[data-tooltip=
][data-placement=3Dbottom]::before{top:100%;bottom:auto;transform:translate=
(-50%,.25rem)}[data-tooltip][data-placement=3Dbottom]:after{transform:trans=
late(-50%,-.3rem);border:.3rem solid transparent;border-bottom:.3rem solid}=
[data-tooltip][data-placement=3Dleft]::after,[data-tooltip][data-placement=
=3Dleft]::before{top:50%;right:100%;bottom:auto;left:auto;transform:transla=
te(-.25rem,-50%)}[data-tooltip][data-placement=3Dleft]:after{transform:tran=
slate(.3rem,-50%);border:.3rem solid transparent;border-left:.3rem solid}[d=
ata-tooltip][data-placement=3Dright]::after,[data-tooltip][data-placement=
=3Dright]::before{top:50%;right:auto;bottom:auto;left:100%;transform:transl=
ate(.25rem,-50%)}[data-tooltip][data-placement=3Dright]:after{transform:tra=
nslate(-.3rem,-50%);border:.3rem solid transparent;border-right:.3rem solid=
}[data-tooltip]:focus::after,[data-tooltip]:focus::before,[data-tooltip]:ho=
ver::after,[data-tooltip]:hover::before{opacity:1}@media (hover:hover) and =
(pointer:fine){[data-tooltip]:focus::after,[data-tooltip]:focus::before,[da=
ta-tooltip]:hover::after,[data-tooltip]:hover::before{--pico-tooltip-slide-=
to:translate(-50%, -0.25rem);transform:translate(-50%,.75rem);animation-dur=
ation:.2s;animation-fill-mode:forwards;animation-name:tooltip-slide;opacity=
:0}[data-tooltip]:focus::after,[data-tooltip]:hover::after{--pico-tooltip-c=
aret-slide-to:translate(-50%, 0rem);transform:translate(-50%,-.25rem);anima=
tion-name:tooltip-caret-slide}[data-tooltip][data-placement=3Dbottom]:focus=
::after,[data-tooltip][data-placement=3Dbottom]:focus::before,[data-tooltip=
][data-placement=3Dbottom]:hover::after,[data-tooltip][data-placement=3Dbot=
tom]:hover::before{--pico-tooltip-slide-to:translate(-50%, 0.25rem);transfo=
rm:translate(-50%,-.75rem);animation-name:tooltip-slide}[data-tooltip][data=
-placement=3Dbottom]:focus::after,[data-tooltip][data-placement=3Dbottom]:h=
over::after{--pico-tooltip-caret-slide-to:translate(-50%, -0.3rem);transfor=
m:translate(-50%,-.5rem);animation-name:tooltip-caret-slide}[data-tooltip][=
data-placement=3Dleft]:focus::after,[data-tooltip][data-placement=3Dleft]:f=
ocus::before,[data-tooltip][data-placement=3Dleft]:hover::after,[data-toolt=
ip][data-placement=3Dleft]:hover::before{--pico-tooltip-slide-to:translate(=
-0.25rem, -50%);transform:translate(.75rem,-50%);animation-name:tooltip-sli=
de}[data-tooltip][data-placement=3Dleft]:focus::after,[data-tooltip][data-p=
lacement=3Dleft]:hover::after{--pico-tooltip-caret-slide-to:translate(0.3re=
m, -50%);transform:translate(.05rem,-50%);animation-name:tooltip-caret-slid=
e}[data-tooltip][data-placement=3Dright]:focus::after,[data-tooltip][data-p=
lacement=3Dright]:focus::before,[data-tooltip][data-placement=3Dright]:hove=
r::after,[data-tooltip][data-placement=3Dright]:hover::before{--pico-toolti=
p-slide-to:translate(0.25rem, -50%);transform:translate(-.75rem,-50%);anima=
tion-name:tooltip-slide}[data-tooltip][data-placement=3Dright]:focus::after=
,[data-tooltip][data-placement=3Dright]:hover::after{--pico-tooltip-caret-s=
lide-to:translate(-0.3rem, -50%);transform:translate(-.05rem,-50%);animatio=
n-name:tooltip-caret-slide}}@keyframes tooltip-slide{to{transform:var(--pic=
o-tooltip-slide-to);opacity:1}}@keyframes tooltip-caret-slide{50%{opacity:0=
}to{transform:var(--pico-tooltip-caret-slide-to);opacity:1}}[aria-controls]=
{cursor:pointer}[aria-disabled=3Dtrue],[disabled]{cursor:not-allowed}[aria-=
hidden=3Dfalse][hidden]{display:initial}[aria-hidden=3Dfalse][hidden]:not(:=
focus){clip:rect(0,0,0,0);position:absolute}[tabindex],a,area,button,input,=
label,select,summary,textarea{-ms-touch-action:manipulation}[dir=3Drtl]{dir=
ection:rtl}@media (prefers-reduced-motion:reduce){:not([aria-busy=3Dtrue]),=
:not([aria-busy=3Dtrue])::after,:not([aria-busy=3Dtrue])::before{background=
-attachment:initial!important;animation-duration:1ms!important;animation-de=
lay:-1ms!important;animation-iteration-count:1!important;scroll-behavior:au=
to!important;transition-delay:0s!important;transition-duration:0s!important=
}}
\ No newline at end of file
--=20
2.34.1

