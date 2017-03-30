class Generateur

        @grid

        attr_reader :grid

        def initialize()
                @grid = Array.new()
                ligne = Array.new()


                9.times do
                        val = 1+rand(9)
                        while(ligne.include? val)
                                val = 1+rand(9)
                        end
                        ligne.unshift(val)
                end

                3.times do
                        3.times do
                                @grid.push(ligne.clone)
                                3.times do
                                        ligne.unshift(ligne.pop())
                                end
                        end
                        ligne.unshift(ligne.pop())
                end

                4.times do
                        a = rand(3)
                        b = rand(3)
                        while(a == b)
                                b = rand(3)
                        end

                        switchrow(a, b)
                        switchcol(a, b)
                        switchrow(5-a, 5-b)
                        switchcol(8-a, 8-b)
                end
        end

        def generer(d)
        	complexifier(d)
        end

        def switchrow(a, b)
                @grid[a], @grid[b] = @grid[b], @grid[a]
        end

        def switchcol(a, b)

                @grid.map {|e| e[a], e[b] = e[b], e[a]}
        end

        def complexifier(d)

                present = Array.new
                9.times do
                        val = 1+rand(9)
                        while(present.include? val)
                                val = 1+rand(9)
                        end
                        present.unshift(val)
                end

                1.upto(d) do
                        victime = present.pop()
                        @grid.each do |a|
                                a.each_with_index do |c, index|
                                        if c == victime
                                                a[index] = nil
                                        end
                                end
                        end
                end


                        nbkill = 0
                        @grid.each do |a|
                                nbkill += a.count(nil)
                        end
                        nbkill = (81-nbkill)*d*0.1

                        0.upto(nbkill) do
                                x = rand(9)
                                y = rand(9)
                                while(@grid[x][y] == nil)
                                        x = rand(9)
                                        y = rand(9)
                                end
                                @grid[x][y] = nil
                        end
                return @grid
        end

        def convert()

                res = Array.new()
                ligne = Array.new()
                val = Hash.new()
                val["value"] = nil
                val["unique"] = true

                @grid.each do |line|
                        line.each do |elem|
                                val["value"] = elem
                                ligne.push(val.clone())
                        end
                        res.push(ligne.clone())
                        ligne = Array.new()
                end

                return res
        end


end
	
