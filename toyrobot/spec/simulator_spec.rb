
require 'spec_helper'
require_relative '../simulator'

describe Simulator do
  let(:robot) { double("robot") }
  let(:simulator) { Simulator.new }
  
  before do
    allow(Robot).to receive(:new).and_return(robot)
  end
  
  describe '#dispatch' do
    describe 'empty string' do
      
      it 'completely ignores the command' do
        expect{ simulator.dispatch('') }.to output("Invalid input: \n").to_stdout
      end
    end
    
    describe "PLACE" do
      
      context 'when receving valid co-ordinates with a valid direction' do

          before do
            expect(robot).to receive(:place).and_return([0, 0, "NORTH"])
          end

          it 'places the robot on the table at the specified location and orients it' do
            simulator.dispatch('PLACE 0,0,NORTH')
          end
        end

        context 'when receving valid co-ordinates with an invalid direction' do

          before do
            expect(robot).to receive(:place).and_return(false)
          end

          it 'does not place the robot on the table' do
            expect{ simulator.dispatch('PLACE 0,0,WOMBLES') }.to output("Please place robot on the table.\n").to_stdout
          end
        end
        
        context 'when receving invalid co-ordinates with an valid direction' do

          before do
            expect(robot).to receive(:place).and_return(false)
          end

          it 'does not place the robot on the table' do
            expect{ simulator.dispatch('PLACE 6,0,NORTH') }.to output("Please place robot on the table.\n").to_stdout
          end
        end
      end
      
  end
  
  describe 'before the robot has been placed' do
      
      before { allow(robot).to receive(:placed).and_return(false) }
      
      describe 'LEFT' do

        before { expect(robot).not_to receive(:left) }

        it 'warns the user but does nothing else' do
          expect{ simulator.dispatch('LEFT') }.to output("Ignoring LEFT until robot is PLACED.\n").to_stdout
        end
      end
      
      describe 'RIGHT' do

        before { expect(robot).not_to receive(:right) }

        it 'warns the user but does nothing else' do
          expect{ simulator.dispatch('RIGHT') }.to output("Ignoring RIGHT until robot is PLACED.\n").to_stdout
        end
      end
      
      describe 'REPORT' do

        before { expect(robot).not_to receive(:report) }

        it 'warns the user but does nothing else' do
          expect{ simulator.dispatch('REPORT') }.to output("Ignoring REPORT until robot is PLACED.\n").to_stdout
        end
      end
      

      describe 'MOVE' do

        before { expect(robot).not_to receive(:move) }

        it 'warns the user but does nothing else' do
          expect{ simulator.dispatch('MOVE') }.to output("Ignoring MOVE until robot is PLACED.\n").to_stdout
        end
      end
    end
    
    describe 'after the robot has been placed' do

      before { allow(robot).to receive(:placed).and_return(true) }

      describe 'LEFT' do

        before { expect(robot).to receive(:left) }

        it 'instructs the robot to turn left' do
          simulator.dispatch('LEFT')
        end
      end

      describe 'MOVE' do

        describe 'move to a valid place on the table' do

          before { expect(robot).to receive(:move) }

          it 'retrieves a movement vector from the robot and applies it to the table' do
            simulator.dispatch('MOVE')
          end
        end

        describe 'RIGHT' do

          before { expect(robot).to receive(:right) }

          it 'instructs the robot to turn' do
            simulator.dispatch('RIGHT')
          end
        end
        
        describe 'REPORT' do

          before { expect(robot).to receive(:report) }

          it 'instructs the robot to report the current location' do
            simulator.dispatch('report')
          end
        end
        
      end
end

