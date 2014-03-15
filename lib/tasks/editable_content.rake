namespace :db do
  desc "Fill db with initial content for editable content"
  task :populate_content => :environment do
    #clear existing content
    EditableContent.destroy_all
    EditableContent.create!(:name => "home",
                            :content => <<-end_content
<h2>Welcome to the Zeta Psi Fraternity at the University of Alberta</h2>
<p>
	Zeta Psi has a long and illustrious history at the University of Alberta as a fraternity
that seeks to enrich the lives of its members beyond the traditional scope of university
education. Zeta Psi has a long-standing commitment to build a brotherhood of men that
strive for academic excellence, while seeking to build leadership and moral fiber in
service of their communities. We seek to achieve these goals while remembering that
university life represents something that should be enjoyed and celebrated.
<br/><br/>
	In short, we aim to “…turn out into the world self-respecting, original-thinking, self-
controlled, purposeful gentlemen”.
</p>
end_content
)
    EditableContent.create!(:name => "about",
                            :content => <<-end_content
<h1>The History of Zeta Psi and of the Mu Theta Chapter</h1>

<p>
Zeta Psi was founded on June 1st 1847 by a group of three young men at New York
University. William Henry Dayton, John Bradt Yates Sommers and John Moon Skillman
had, thus, created the 11th Greek letter society in America. With its 43 currently active
chapters, Zeta Psi has since been labeled a major pioneer in the fraternity system.
Zeta Psi was the first fraternity to establish a chapter on the west coast of the United
States at Berkely in the newly formed state of California (1970). However, Zeta Psi
did not content itself with national status. In 1879, the Theta Xi chapter was formed at
the University of Toronto– making Zeta Psi the first fraternity in Canada and the first
international fraternity. In 2008, Zeta Psi broke new ground again and formed a chapter
at Oxford University to become the first intercontinental fraternity. More recently, Zeta
Psi has been the first fraternity to establish chapters at Brock (2009) and Queens (2010)
Universities.
</p>

<p>
	In the early years of the University of Alberta, fraternities were banned from campus. Dr.
Tory was adamant about keeping student societies from forming sub-groups and opinions
of their own within the University Community. Thus, when Zeta Psi formed a colony of
15 men at the UofA in 1926, it was dubbed the ‘Corinthian Club’ to maintain secrecy.
Due to the contentious nature of this name, it was later changed to the ‘Athenian Club’.
In 1930, the ban on fraternities was lifted by Dr. Wallace: the UofA’s new president. On
October 30th of that year, Zeta Psi’s Mu Theta chapter was established to become the first
fraternity at the UofA.
</p>

<p>
There have been many famous and successful Zetes:
   <ul style="list-style:disc; padding-left:20px; line-height:18px">
    <li>Lieutenant Colonel Dr. John Alexander MacCrae, Author of "Flanders Fields"</li>
    <li>Henry Ford II, Chairman of Ford Motor Company</li>
    <li>Dean Cain, Actor (Superman)</li>
    <li>Lesley S. Aspin, Former Secretary of Defence for the USA</li>
    <li>Jon K. Grant, Chairman of Quaker Oats Canada</li>
    <li>Arden Haynes, Chairman and CEO of Imperial Oil</li>
    <li>Peter B. Wilson, Former Governor of California</li>
    <li>Admiral James J. Carey, United States Navy Reserves</li>
    <li>Dr. Julius A. Stratton, President Emeritus of MIT</li>
    <li>John R. Brodie, NFL Hall of Fame</li>
    <li>Biran Dickson, Retired Chief Justice of the Supreme Court of Canada</li>
    <li style="list-style:none">and many more...</li>
   </ul>
</p>

<p>
	Throughout its history, Zeta Psi has striven to promote excellence in its members,
through all facets of University life and beyond. Though being a member Zeta Psi is
significant phase in ones undergraduate life, it represents much more than that. For more
information, please <a href="/contact">contact us</a>.
</p>
end_content
)
    EditableContent.create!(:name => "contact",
                            :content => <<-end_content
<h1>Contact Us</h1>

<p>For general inquiries, please email us at 
  <%= mail_to "zetapsi.mutheta@gmail.com"%>.
</p>

<p>For more specific inquiries, please contact us directly:
</p>

<h2>President - Max Anderson</h2>
<p>
Phone - (780) 123-4567 <br>
Email - <%= mail_to "max@gmail.com" %>
</p>

<h2>Social Chair - Dempsey Bolton</h2>
<p>
Phone - (780) 123-4567 <br>
Email - <%= mail_to "max@gmail.com" %>
</p>

<h2>Web Developer - Steve Jahns</h2>
<p>
Phone - (780) 123-4567 <br>
Email - <%= mail_to "max@gmail.com" %>
</p>
end_content
)
  end
end
