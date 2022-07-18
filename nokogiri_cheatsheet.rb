# id
doc.search('#banner')

# class
doc.search('.class_name')

# html object
doc.search('h1')

# search for child inside of parent
doc.search('.parent_class_name .child_class_name')
doc.search('#banner p')
doc.search('.side_container .item_title')

# search for element with two classes on it
doc.search('.container.card')

# .search
# will always give you an array of nokogiri elements
